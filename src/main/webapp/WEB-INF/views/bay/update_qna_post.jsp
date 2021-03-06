<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdn.ckeditor.com/4.9.2/standard-all/ckeditor.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      $("#update_btn").click(function() {
         var data = CKEDITOR.instances.content.getData();
         if ($("#title").val() == "") {
            alert("제목을 입력하세요!");
            return false;
         }
         if (data == "") {
            alert("본문을 입력하세요!");
            return false;
         }
      });
      $("#resetBtn").click(function() {
         if(confirm("수정을 취소하시겠습니까?")){
            location.href="detail_qna_post.do?bayPostNo="+${qvo.bayPostNo};
         }
      });
   });
</script>
</head>
<body>
   <!-- container-fluid: 화면 너비와 상관없이 항상 100% -->
   <div class="container">
      <div class="row header">
      <form action="updateQnaPost.do" method="post" id="update_form">
         <input type="hidden" name="bayPostNo" value="${qvo.bayPostNo}">
         <div class="col-sm-2">
         <select name="subjectVO.subjectNo">
         <c:choose>
                  <c:when test="${sessionScope.member.id ne 'sys'}">
                     <option value="4">육아</option>
                     <option value="5">상품</option>
                     <option value="6">기타</option>
                  </c:when>
                  <c:otherwise>
                     <option value="7">공지사항</option>
                  </c:otherwise>
               </c:choose>
            </select>   
         </div>
         <div class="col-sm-8">
         <textarea cols="90" rows="1" name="title" id="title" required="required">${qvo.title}</textarea>
         </div>
         <br><br>
                   <textarea cols="90" rows="15" name="content" id="content">${qvo.content}</textarea>
               <div class="btnArea">
                  <button type="submit"  id="update_btn" class="btn">수정</button>
                  <button type="reset" id="resetBtn" class="btn">취소</button>
               </div>               
            </form>
         </div>
   </div>
   <!-- 에디터 스크립트 소스
    -->
   <script>
      // Don't forget to add CSS for your custom styles.
      CKEDITOR.addCss( 'figure[class*=easyimage-gradient]::before { content: ""; position: absolute; top: 0; bottom: 0; left: 0; right: 0; }' +
         'figure[class*=easyimage-gradient] figcaption { position: relative; z-index: 2; }' +
         '.easyimage-gradient-1::before { background-image: linear-gradient( 135deg, rgba( 115, 110, 254, 0 ) 0%, rgba( 66, 174, 234, .72 ) 100% ); }' +
         '.easyimage-gradient-2::before { background-image: linear-gradient( 135deg, rgba( 115, 110, 254, 0 ) 0%, rgba( 228, 66, 234, .72 ) 100% ); }' );

      CKEDITOR.replace( 'content', {
         extraPlugins: 'easyimage',
         removePlugins: 'image',
         removeDialogTabs: 'link:advanced',
         toolbar: [
            { name: 'document', items: [ 'Undo', 'Redo' ] },
            { name: 'styles', items: [ 'Format' ] },
            { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Strike', '-', 'RemoveFormat' ] },
            { name: 'paragraph', items: [ 'NumberedList', 'BulletedList' ] },
            { name: 'links', items: [ 'Link', 'Unlink' ] },
            { name: 'insert', items: [ 'EasyImageUpload' ] }
         ],
         height: 630,
         cloudServices_uploadUrl: 'https://33333.cke-cs.com/easyimage/upload/',
         // Note: this is a token endpoint to be used for CKEditor 4 samples only. Images uploaded using this token may be deleted automatically at any moment.
         // To create your own token URL please visit https://ckeditor.com/ckeditor-cloud-services/.
         cloudServices_tokenUrl: 'https://33333.cke-cs.com/token/dev/ijrDsqFix838Gh3wGO3F77FSW94BwcLXprJ4APSp3XQ26xsUHTi0jcb1hoBt',
         easyimage_styles: {
            gradient1: {
               group: 'easyimage-gradients',
               attributes: {
                  'class': 'easyimage-gradient-1'
               },
               label: 'Blue Gradient',
               icon: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/gradient1.png',
               iconHiDpi: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/hidpi/gradient1.png'
            },
            gradient2: {
               group: 'easyimage-gradients',
               attributes: {
                  'class': 'easyimage-gradient-2'
               },
               label: 'Pink Gradient',
               icon: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/gradient2.png',
               iconHiDpi: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/hidpi/gradient2.png'
            },
            noGradient: {
               group: 'easyimage-gradients',
               attributes: {
                  'class': 'easyimage-no-gradient'
               },
               label: 'No Gradient',
               icon: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/nogradient.png',
               iconHiDpi: 'https://sdk.ckeditor.com/https://sdk.ckeditor.com/samples/assets/easyimage/icons/hidpi/nogradient.png'
            }
         },
         easyimage_toolbar: [
            'EasyImageFull',
            'EasyImageSide',
            'EasyImageGradient1',
            'EasyImageGradient2',
            'EasyImageNoGradient',
            'EasyImageAlt'
         ]
      } );
   </script>