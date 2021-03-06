package org.kosta.momsbay.controller;

import javax.annotation.Resource;

import org.kosta.momsbay.model.exception.TradeException;
import org.kosta.momsbay.model.service.HistoryService;
import org.kosta.momsbay.model.service.PointService;
import org.kosta.momsbay.model.service.RatingService;
import org.kosta.momsbay.model.service.TradePostService;
import org.kosta.momsbay.model.service.TradeService;
import org.kosta.momsbay.model.vo.MemberVO;
import org.kosta.momsbay.model.vo.TradePostVO;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * TradePost 처리하는 Controller.
 * 관련Service: TradeService, BayPostService, TradePostService
 * @author 개발제발
 *
 */
@RequestMapping("/trade")
@Controller
public class TradeController {
	@Resource
	private TradePostService tradePostService;
	@Resource
	private HistoryService historyService;
	@Resource
	private PointService pointService;
	@Resource
	private TradeService tradeService;
	@Resource
	private RatingService ratingService;
	
	/**
	 * 거래신청 완료시 실행.
	 * 판매자와 구매자 모두 거래내역에 거래중으로 기록.
	 * 구매자의 포인트를 가격만큼 감소.
	 * @param tradePostNo
	 * @param id
	 * @param tradeId
	 * @param boardTypeNo
	 * @param model
	 * @return detail_trade_post.jsp
	 * @author Jung
	 */
	@Transactional
	@RequestMapping(method= RequestMethod.POST,value="applyTransaction.do")
	public String applyTrade(TradePostVO tradePostVO, Model model){
		if (tradePostVO.getBoardTypeNo()==2) {
			try {
				tradeService.applyTransaction(tradePostVO);
			} catch (TradeException e) {
				model.addAttribute("message", e.getMessage());
				model.addAttribute("tradePostNo", tradePostVO.getTradePostNo());
				return "trade/trade_fail";
			}
			tradePostService.updateTradeId(tradePostVO);
			tradePostVO.setTradeType("판매");
			historyService.addTradeHistory(tradePostVO);
			String temp = tradePostVO.getTradeId();
			tradePostVO.setTradeId(tradePostVO.getMemberVO().getId());
			tradePostVO.getMemberVO().setId(temp);
			tradePostVO.setTradeType("구매");
			historyService.addTradeHistory(tradePostVO);
		} else {
			try {
				tradeService.applyTransaction(tradePostVO);
				historyService.updateDepositTradeHistory(tradePostVO);
			} catch (TradeException e) {
				model.addAttribute("message", e.getMessage());
				model.addAttribute("tradePostNo", tradePostVO.getTradePostNo());
				return "trade/trade_fail";
			}
		}
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostVO.getTradePostNo()+"";
	}
	
	/**
	 * 거래 취소.
	 * 구매자의 깎인 금액을 되돌려준다.
	 * 게시글의 거래아이디를 삭제.
	 * 판매자와 구매자의 거래내역을 삭제.
	 * @param tradeId
	 * @param id
	 * @param tradePostNo
	 * @return detail_trade_post.jsp
	 * @author Jung
	 */
	@Transactional
	@RequestMapping(method= RequestMethod.POST,value="cancelTransaction.do")
	public String cancelTransaction(String tradeId, String id, String tradePostNo,String boardTypeNo) {
		TradePostVO tradePostVO = new TradePostVO();
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		tradePostVO.setTradeId(tradeId);
		tradePostVO.setMemberVO(memberVO);
		tradePostVO.setTradePostNo(Integer.parseInt(tradePostNo));
		
		if(boardTypeNo.equals("2")) {
			tradeService.cancelTransaction(tradePostVO);
			tradePostService.deleteTradeId(tradePostVO.getTradePostNo());
			historyService.deleteTradeHistory(tradePostVO);
			
			String temp = tradePostVO.getTradeId();
			tradePostVO.setTradeId(tradePostVO.getMemberVO().getId());
			tradePostVO.getMemberVO().setId(temp);
			historyService.deleteTradeHistory(tradePostVO);
		}
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostNo;
	}
	
	/**
	 * 거래완료.
	 * 판매자에게 금액을 입금.
	 * 거래내역을 거래완료로 업데이트.
	 * 게시글의 거래상태를 거래완료로 수정.
	 * 판매자와 구매자의 포인트 내역을 생성.
	 * @param tradePostNo
	 * @param id
	 * @param tradeId
	 * @return list_trade_history.jsp
	 * @author Jung
	 */
	@Transactional
	@RequestMapping(method= RequestMethod.POST,value="completeTransaction.do")
	public String completeTransaction(String boardTypeNo, String tradePostNo, String id, String tradeId,String rating) {
		TradePostVO tradePostVO = new TradePostVO();
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		memberVO.setRating(Integer.parseInt(rating));
		tradePostVO.setTradeId(tradeId);
		tradePostVO.setMemberVO(memberVO);
		tradePostVO.setTradePostNo(Integer.parseInt(tradePostNo));
		memberVO.setRating(Integer.parseInt(rating));
		
		int price=tradePostService.findPirceByTradePostNo(tradePostVO.getTradePostNo());
		tradePostService.updateTradeId(tradePostVO);
		historyService.updateCompleteTradeHistory(tradePostVO);
		
		if (boardTypeNo.equals("2") || boardTypeNo == "2") {
			tradeService.completeTransaction(tradePostVO);
			historyService.addPointBuyHistory(tradePostVO.getTradeId(), price);
			historyService.addPointSellHistory(tradePostVO.getMemberVO().getId(), price);
			ratingService.updateRating(memberVO);
		}else {
			historyService.addPointBuyHistory(tradePostVO.getMemberVO().getId(), price);
			historyService.addPointSellHistory(tradePostVO.getTradeId(), price);
			memberVO.setId(tradeId);
			tradePostVO.setTradeId(id);
			tradeService.completeTransaction(tradePostVO);
			ratingService.updateRating(memberVO);
		}
		return "redirect:/myaccount/findTradeHistoryListById.do";
	}
	
	
	/**
	 * 판매자가 물품배송을 완료.
	 * 판매자 거래내역의 거래상태를 물품배송으로 변경.
	 * @param tradePostNo
	 * @param id
	 * @param tradeId
	 * @return detail_trade_post.jsp
	 * @author Jung
	 */
	@RequestMapping(method= RequestMethod.POST,value="updateDeliveryTradeHistory.do")
	public String updateDeliveryTradeHistory(String tradePostNo, String id, String tradeId) {
		TradePostVO tradePostVO = new TradePostVO();
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		tradePostVO.setTradeId(tradeId);
		tradePostVO.setMemberVO(memberVO);
		tradePostVO.setTradePostNo(Integer.parseInt(tradePostNo));
		historyService.updateDeliveryTradeHistory(tradePostVO);
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostVO.getTradePostNo()+"";
	}
	
	/**
	 * 판매 신청 페이지에서 판매할 제품에 대한 글을 쓰고 거래신청.
	 * @param tradePostVO
	 * @return
	 */
	@RequestMapping("/applySell.do")
	public String applySell(TradePostVO tradePostVO, Model model) {
		tradePostService.updateTradeIdAndSuggestContent(tradePostVO);
		TradePostVO tVO = tradePostService.findTradePostByTradePostNo(tradePostVO.getTradePostNo());
		tVO.getMemberVO().setId(tradePostVO.getTradeId());
		tVO.setTradeId(tradePostVO.getMemberVO().getId());
		tVO.setTradeType("판매");
		historyService.addTradeHistory(tVO);
		tradePostVO.setTradeId(tradePostVO.getTradeId());
		tradePostVO.setTradeType("구매");
		historyService.addTradeHistory(tradePostVO);
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostVO.getTradePostNo();
	}
	
	/**
	 * 삽니다 게시판에서 취소.
	 * @param tradePostNo
	 * @return detail_trade_post.jsp
	 * @author Jung
	 */
	@RequestMapping(method= RequestMethod.POST,value="cancelTransaction2.do")
	public String cancelTransaction2(String tradePostNo) {
		TradePostVO tradePostVO = new TradePostVO();
		tradePostVO.setTradePostNo(Integer.parseInt(tradePostNo));
		tradePostService.deleteTradeId(tradePostVO.getTradePostNo());
		historyService.deleteTradeHistory(tradePostVO);
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostNo;
	}
	
	@Transactional
	@RequestMapping(method= RequestMethod.POST,value="deposit.do")
	public String deposit(String tradePostNo, String id, String tradeId, String boardTypeNo, Model model) {
		TradePostVO tradePostVO = new TradePostVO();
		MemberVO memberVO = new MemberVO();
		memberVO.setId(id);
		tradePostVO.setTradeId(tradeId);
		tradePostVO.setMemberVO(memberVO);
		tradePostVO.setBoardTypeNo(Integer.parseInt(boardTypeNo));
		tradePostVO.setTradePostNo(Integer.parseInt(tradePostNo));
		try {
			tradeService.applyTransaction(tradePostVO);
			historyService.updateDeliveryTradeHistory(tradePostVO);
		} catch (TradeException e) {
			model.addAttribute("message", e.getMessage());
			model.addAttribute("tradePostNo", tradePostVO.getTradePostNo());
			return "trade/trade_fail";
		}
		return "redirect:detail_trade_post.do?tradePostNo="+tradePostVO.getTradePostNo()+"";
	}
	
}





