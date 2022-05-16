<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="container">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item"><a class="nav-link active" id="review-tab"
			data-toggle="tab" href="#review" role="tab" aria-controls="review"
			aria-selected="false">Reviews</a></li>
	</ul>
	
	<div class="tab-pane fade show active" id="review" role="tabpanel"
		aria-labelledby="review-tab">
		<div class="row">
			<div class="col-lg-6">
				
				<div class="review_list">
					<div class="review_item" role="grid">
						
						<c:forEach items="${reviewListVO }" var="reviewVO" varStatus="status">
					
						<div class="media">
							<input type="hidden" name="rev_num" value="${reviewVO.rev_num }">
								Rating : ${reviewVO.rev_score } <input type="hidden" name="rev_score" value="${reviewVO.rev_score }">
								<c:set var="star" />
								<c:choose>
									<c:when test="${ reviewVO.rev_score eq 1 }">
										<c:set var="star" value="★☆☆☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rev_score eq 2 }">
										<c:set var="star" value="★★☆☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rev_score eq 3 }">
										<c:set var="star" value="★★★☆☆" />
									</c:when>
									<c:when test="${ reviewVO.rev_score eq 4 }">
										<c:set var="star" value="★★★★☆" />
									</c:when>
									<c:when test="${ reviewVO.rev_score eq 5 }">
										<c:set var="star" value="★★★★★" />
									</c:when>
								</c:choose>
								
								<c:out value="${star }" />	
						</div>
						<div><input type="hidden" name="rev_content">
						<p>&nbsp;&nbsp; ${reviewVO.rev_content }</p>
						</div>
						<br>
							${fn:substring(reviewVO.mem_id, 0, 4)  }***** | <fmt:formatDate value="${reviewVO.rev_regdate }" pattern="yyyy-MM-dd HH:mm" />
						<div>
							<button type="button" name="btnReviewEditModal" class="btn btn-link">수정</button>
							<button type="button" name="btnReviewDelModal" class="btn btn-link">삭제</button>
						</div>
						<hr>
						</c:forEach>
						
					</div>
				</div>
			
			</div>
			<div class="col-lg-6">
				<div class="review_box">
					<h4>Add a Review</h4>
					<div class="rating">
						<p>Your Rating:</p>
						<p id="star_grade">
							<a href="#">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
						</p>
				    </div>
					
						<div class="col-md-12">
							<div class="form-group">
								<input type="hidden" id="reviewNum">
								<input type="hidden" id="reviewScore">
								<textarea class="form-control" id="reviewContent" name="message" rows="3"
									placeholder="Review"></textarea>
							</div>
						</div>
						<br>
						<div class="col-md-12 text-right">
							<button id="btnReviewAdd" class="btn_3">Submit Now</button>
							<button id="btnReviewEdit" style="display: none;" class="btn_3">Review Edit</button>							
						</div>
				 </div>
			</div>
		</div>
	</div>
	
</div>

<!-- 페이징 부분 -->

		<div class="col-sm-12 box">
			<nav aria-label="Page navigation example" >
			  <ul class="pagination" >
			  <c:if test="${pageMaker.prev }">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			   </c:if>
			   <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
			    <li class="page-item ${pageMaker.cri.pageNum == num ? 'active':'' }"><a class="page-link" href="${num}">${num}</a></li>
			   </c:forEach>
			   <c:if test="${pageMaker.next }">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			   </c:if>
			  </ul>
			</nav>
			
		</div>
		<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="reviewForm" action="/review/productReview" method="get" >
			<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			
			<!--글번호추가-->
		</form>
