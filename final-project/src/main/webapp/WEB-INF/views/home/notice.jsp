<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<style>
ul{
	list-style:none;
}
</style>


<figure class="text-center mt-2">
	<blockquote class="blockquote">
		<i class='bx bx-edit-alt'></i>
		<p class="mb-0">공지사항을 작성해볼까요?</p>
	</blockquote>
	<figcaption class="blockquote-P">
		우리 회사 구성원들에게 알려주고 싶은 내용을 공지사항으로 작성해보세요!
	</figcaption>
</figure>
		
<c:choose>
	<c:when test="${not empty noticeList}">

		<figure class="text-center mt-2">
			<blockquote class="blockquote">
				<i class='bx bx-edit-alt'></i>
				<p class="mb-0">공지사항을 작성해볼까요?</p>
			</blockquote>
			<figcaption class="blockquote-P">
				우리 회사 구성원들에게 알려주고 싶은 내용을 공지사항으로 작성해보세요!
			</figcaption>
		</figure>
		
	</c:when>
	
	<c:otherwise>
		<ul class="" style="list-style:none;">
			<li class="">
				<div class="">
					<div class="">

					<div class="dropdown">
				        <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="bx bx-dots-vertical-rounded"></i></button>
				        <div class="dropdown-menu">
				        	<span class="dropdown-item "><i class='bx bx-pencil me-1' ></i>수정하기</span>
				        	<span class="dropdown-item text-danger"><i class="bx bx-x bx-sm me-1"></i>삭제하기</span>
						</div>
					</div>
					
						<div class="">
							<div
								class="">
						<div style="display: inline-block;">
							<a href="#" class="menu-link" >
								<img src="${cPath}/resources/assets/img/avatars/5.png"
										alt="Avatar" class="rounded-circle w-px-50 h-px-50">
								<div class="mx-3 mt-1">
										<strong>김판다</strong><br> <span class="fs-tiny">마케터</span>
								</div>
							</a>
						</div>
								<div
									class="">
									<div
										class="">
										<div
											class="">
											<span class="">건강
												<span class="">
													<span data-state="closed">1분 미만 전</span>
												</span>
											</span>
										</div>
									</div>
									<span class=" "><div
											class="">
											<span><span data-lokalise="true"
												data-key="notice.list.subtext.님">김나비님</span></span>
											<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
												xmlns="http://www.w3.org/2000/svg"
												style="width: 18px; height: 18px; flex-shrink: 0;">
												<path d="M14.0951 12.5203C14.404 12.2423 14.404 11.7578 14.0951 11.4797L10.8415 8.55147C10.391 8.14605 9.67319 8.46573 9.67319 9.07177V14.9283C9.67319 15.5343 10.391 15.854 10.8415 15.4486L14.0951 12.5203Z"
													fill="#8d96a1"></path></svg>
											<button type="button" data-state="closed"
												aria-haspopup="dialog" aria-expanded="false"
												aria-controls="radix-228"
												class="">
												<span data-lokalise="true" data-key="notice.recipients.모두에게">모두에게</span>
											</button>
										</div></span>
								</div>
							</div>
						</div>
						<div
							class=""
							style="padding-left: 54px; margin-top: 10px;">
							<p class="">
								<span class="">하세요</span>
							</p>
						</div>
					</div>
				</div></li>
			<div aria-hidden="true" class="c-beIqCh"></div>
		</ul>
	</c:otherwise>			
</c:choose>