package org.kosta.momsbay.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.kosta.momsbay.model.vo.BayCommentVO;
/**
 * 일반 게시판 DB연동 Mapper.
 * @author 개발제발
 */
@Mapper
public interface BayCommentMapper {
	public List<BayCommentVO> getBayCommentList(int bayPostNo);
}
