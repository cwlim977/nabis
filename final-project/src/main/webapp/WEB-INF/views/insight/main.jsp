<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

<!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${cPath }/resources/assets/vendor/fonts/boxicons.css" />

<!-- font, https://fonts.google.com/specimen/Gowun+Dodum?subset=korean&noto.script=Kore 'Gowun Dodum' -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">

<script src="https://netdna.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
<script>
$(function () {
	
//메인 컨테이너 클래스 삭제
$('#delContainer').closest('.container-xxl').removeClass( 'container-xxl flex-grow-1 container-p-y' );
})
</script>
<!-- Layout container -->
<!--         <div class="layout-page"> -->
          <!-- Navbar -->

<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
.gowun-normal{
	font-family: 'Gowun Dodum', sans-serif;
	font-weight: bold;
}
.gowun-bold{
	font-family: 'Gowun Dodum', sans-serif;
	font-weight: bold;
}

.custom-ul{
 	list-style: none;
    margin: 0px;
    padding: 0px;
    
	border-top : 1px solid #efefef;

    width: 100%;
    max-width: 2100px;
	background-color: #efefef;
}
ul.custom-ul li{
	display : inline-block; 
	float : right;
	border : 1px solid #efefef;
	width: 700px;
/* 	max-width: 33.3333%;  */
	flex-basis: 33.3333%;
	background-color: 
}
.ul-cover-div{
	display : inline-block;
	padding: 32px 10px;
}
.insight-main-title{
	list-style: none;
	margin-top: 0px;
	margin-bottom: 16px;
	letter-spacing: 0;
	text-align: left;
	display: flex;
	align-items: center;
	justify-content: space-between;
}
h4{
    margin-block-start: 1.33em;
    margin-block-end: 1.33em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
.serial-section{
	margin-top : 60px;
}
.chart-table-01{
	margin: 30px;
}
.table-p5p2{
	padding: 5px 2px;
}
.table-p5p2>tbody>tr>td{
	padding: 5px 5px;
}
.table-p5p2>tbody>tr>th{
	padding: 5px 5px;
}

</style>

<div id="delContainer"></div>
<div style="background: linear-gradient(to bottom, #e9e9fc 00%, #ffffff 100%);">
          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
          >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <!-- Search -->
              <div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                  <i class="bx bx-search fs-4 lh-0"></i>
					<input type="text" name="searchDatefilter" value="" class="form-control border-0 shadow-none" required="required" placeholder="조회기간선택"
                    aria-label="Search..."/>
                </div>
              </div>
              <!-- /Search -->

              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- Place this tag where you want the button to render. -->
                <li class="nav-item lh-1 me-3">
                <!-- 조회연도변경 -->
                  <div class="dropdown">
                    <button class="btn btn-sm btn-outline-primary dropdown-toggle" name="out-year-datepicker" type="button" id="out-year-datepicker" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      2022
                    </button>
                  </div>
                </li>
              </ul>
            </div>
          </nav>

          <!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
                <div class="col-lg-8 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-sm-7">
                        <div class="card-body">
                          <h5 class="card-title text-primary gowun-bold">NABIS의 통계정보시스템 INSIGHT! 🎉</h5>
                          <p class="mb-4 gowun-normal">
                            	기분좋은 아침입니다:) NABIS의 경영통계정보와 함께 즐거운 하루를 시작하세요!
                          </p>

                          <a href="javascript:;" class="btn btn-sm btn-outline-primary">View Badges</a>
                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img
                            src="${cPath }/resources/assets/img/nabis/LOGO08.png"
                            height="140"
                            alt="View Badge User"
                            data-app-dark-img="${cPath }/resources/assets/imgillustrations/man-with-laptop-dark.png"
                            data-app-light-img="${cPath }/resources/assets/imgillustrations/man-with-laptop-light.png"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4 col-md-4 order-1">
                  <div class="row">
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img
                                src="${cPath }/resources/assets/img/icons/unicons/chart-success.png"
                                alt="chart success"
                                class="rounded"
                              />
                            </div>
                            <div class="dropdown">
                              <button
                                class="btn p-0"
                                type="button"
                                id="cardOpt6"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                              >
                                <i class="bx bx-dots-vertical-rounded"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt6">
                                <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                              </div>
                            </div>
                            
                          </div>
                          <span class="fw-semibold d-block mb-1 gowun-bold">재직총원</span>
                          <h3 class="card-title mb-2 gowun-normal" id="nowEmp">0 명</h3>
                          <small id="updownRate" class="text-success fw-semibold" ><i id="updownArrow" class="bx bx-up-arrow-alt"></i>
                          <span id="empRate">+72.80%</span></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img
                                src="${cPath }/resources/assets/img/icons/unicons/wallet-info.png"
                                alt="Credit Card"
                                class="rounded"
                              />
                            </div>
                            <div class="dropdown">
                              <button
                                class="btn p-0"
                                type="button"
                                id="cardOpt6"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                              >
                                <i class="bx bx-dots-vertical-rounded"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt6">
                                <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                              </div>
                            </div>
                          </div>
                          <span class="gowun-bold">수습근로자 수</span>
                          <h3 class="card-title text-nowrap mb-1 gowun-normal" id="prEmpNum">0 명</h3>
                          <small class="text-success fw-semibold"><i class="bx "></i></small>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Total Revenue -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card">
                    <div class="row row-bordered g-0">
                      <div class="col-md-8">
                       <h5 class="card-header m-0 me-2 pb-3 gowun-bold">인적자원관리</h5>
                        <div id="totalRevenueChart" class="px-2"></div>
                      </div>
                      <div class="col-md-4">
                        <div class="card-body">
                          <div class="text-center">
                            <div class="dropdown">
                              <button
                                class="btn btn-sm btn-outline-primary dropdown-toggle"
                                type="button"
                                id="growthReportId"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                              >
                                2022
                              </button>
                              <div class="dropdown-menu dropdown-menu-end" aria-labelledby="growthReportId">
                                <a class="dropdown-item" href="javascript:void(0);">2021</a>
                                <a class="dropdown-item" href="javascript:void(0);">2020</a>
                                <a class="dropdown-item" href="javascript:void(0);">2019</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div id="growthChart"></div>
                        <div class="text-center fw-semibold pt-3 mb-2">5년간 회사 규모성장률</div>

                        <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
                          <div class="d-flex">
                            <div class="me-2">
                              <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
                            </div>
                            <div class="d-flex flex-column">
                              <small>5년간 <br>신규입사자</small>
                              <h6 class="mb-0">56명 </h6>
                            </div>
                          </div>
                          <div class="d-flex">
                            <div class="me-2">
                              <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
                            </div>
                            <div class="d-flex flex-column">
                              <small>5년간 <br>퇴사자</small>
                              <h6 class="mb-0">33명</h6>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Total Revenue -->
                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
                  <div class="row">
                    <div class="col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="${cPath }/resources/assets/img/icons/unicons/paypal.png" alt="Credit Card" class="rounded" />
                            </div>
							<div class="dropdown">
                              <button
                                class="btn p-0"
                                type="button"
                                id="cardOpt6"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                              >
                                <i class="bx bx-dots-vertical-rounded"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt6">
                                <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                              </div>
                            </div>
                          </div>
                          <span class="d-block mb-1 gowun-bold">이직률(퇴사율)</span>
                          <h3 class="card-title text-nowrap mb-2 gowun-normal" id="outRateTag">0%</h3>
                          <small id="outUpdownRate" class="text-danger fw-semibold"><i id="outUpdownArrow" class="bx bx-down-arrow-alt"></i><span class="gowun-normal" id="outRateStat">유지</span></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="${cPath }/resources/assets/img/icons/unicons/cc-primary.png" alt="Credit Card" class="rounded" />
                            </div>
                            <div class="dropdown">
                              <button
                                class="btn p-0"
                                type="button"
                                id="cardOpt1"
                                data-bs-toggle="dropdown"
                                aria-haspopup="true"
                                aria-expanded="false"
                              >
                                <i class="bx bx-dots-vertical-rounded"></i>
                              </button>
                              <div class="dropdown-menu" aria-labelledby="cardOpt1">
                                <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                              </div>
                            </div>
                          </div>
                          <span class="fw-semibold d-block mb-1 gowun-bold	">수습기간완료율</span>
                          <h3 class="card-title mb-2 gowun-normal" id="prRateTag" >100%</h3>
                          <small class="text-success fw-semibold gowun-normal"><i class="bx bx-up-arrow-alt"></i> +28.14%</small>
                        </div>
                      </div>
                    </div>
                    <!-- </div>
    <div class="row"> -->
                    <div class="col-12 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                            <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                              <div class="card-title">
                                <h5 class="text-nowrap mb-2 gowun-bold">자본금증가율</h5>
                                <span class="badge bg-label-warning rounded-pill gowun-normal">2021 년</span>
                              </div>
                              <div class="mt-sm-auto">
                                <small class="text-success text-nowrap fw-semibold"
                                  ><i class="bx bx-chevron-up"></i> 10.2%</small
                                >
                                <h5 class="mb-0 gowun-norml" style="text-align-last:right;">1억 5,000 <br><small>만원</small></h5>
                              </div>
                            </div>
                            <div id="profileReportChart"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              
<!-- 3째줄 -->
              <div class="row">
                <!-- Order Statistics -->
                <div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">
                        <h5 class="m-0 me-2 gowun-normal">계약 유형별 비율</h5>
                        <small class="text-muted gowun-normal">기준 : 재직 구성원</small>
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body offcanvas-scrollbar">		<!-- offcanvas-scrollbar, height : 20vh -->
                      <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex flex-column align-items-center gap-1 gowun-bold">
                          <h2 class="mb-2" id="mem-kind-total-val">0 명</h2>
                          <span>총 재직원 수</span>
                        </div>
                        <div id="donutChart" style="min-height: 146.65px; width: 170px;"></div>
                      </div>
                      <ul class="p-0 m-0 gowun-normal">
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-primary"
                              ><i class="bx bx-mobile-alt"></i
                            ></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0">정규직근로자</h6>
                              <small class="text-muted" id="mem-kind-1">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-1-val">0 %</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-success"><i class="bx bx-closet"></i></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >기간제근로자</h6>
                              <small class="text-muted" id="mem-kind-2">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-2-val">0 %</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-success"><i class="bx bx-closet"></i></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >파견근로자</h6>
                              <small class="text-muted" id="mem-kind-3">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-3-val">0 %</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-success"><i class="bx bx-closet"></i></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >일용근로자</h6>
                              <small class="text-muted" id="mem-kind-4">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-4-val">0 %</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-success"><i class="bx bx-closet"></i></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >특수형태근로종사자</h6>
                              <small class="text-muted" id="mem-kind-5">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-5-val">? 명</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-info"><i class="bx bx-home-alt"></i></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >등기임원</h6>
                              <small class="text-muted" id="mem-kind-6">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-6-val">0 %</small>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex">
                          <div class="avatar flex-shrink-0 me-3">
                            <span class="avatar-initial rounded bg-label-secondary"
                              ><i class="bx bx-football"></i
                            ></span>
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <h6 class="mb-0" >비등기임원</h6>
                              <small class="text-muted" id="mem-kind-7">? 명</small>
                            </div>
                            <div class="user-progress">
                              <small class="fw-semibold" id="mem-kind-7-val">0 %</small>
                            </div>
                          </div>
                        </li>
                      </ul>
                      
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->

				<!-- Expense Overview -->
                <div class="col-md-6 col-lg-4 order-1 mb-4">
                  <div class="card h-100">
                    
                    <div class="card-body px-0">
                      <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                          <div class="d-flex p-4 pt-3">
                            <div class="avatar flex-shrink-0 me-3">
                              <img
                                src="${cPath }/resources/assets/img/icons/unicons/chart-success.png"
                                alt="chart success"
                                class="rounded"
                              />
                            </div>
                            
                            <div class="align-items-center" style="">
                              <h5 class=" me-2 mb-0 gowun-bold">평균 나이 분포</h5>
                              <div class="d-flex align-items-center">
                                <small class="mb-0 me-1 gowun-normal">기준 : 재직 구성원</small>
                              </div>
                            </div>
                          </div>
                          <div class="d-flex justify-content-center pt-4 gap-2">
                           	<div id="memCompChart"></div>
                              
                            </div>
                            
                            <div class="p-4">
                            
	                            <p class="mb-n1 mt-1 gowun-normal">나이대별 구성원 숫자</p>
	                              <small class="text-muted gowun-normal">총원수 : </small>
	                            <br>
	                            <div class="table-responsive">
                              <table class="table table-striped table-p5p2">
                              	<tr><th>10대</th><th>20대</th><th>30대</th><th>40대</th><th>50대</th><th>60대</th><th>기타</th></tr>
                              	<tr>
                              		<td id="tab-age-10">0명</td>
                              		<td id="tab-age-20">0명</td>
                              		<td id="tab-age-30">0명</td>
                              		<td id="tab-age-40">0명</td>
                              		<td id="tab-age-50">0명</td>
                              		<td id="tab-age-60">0명</td>
                              		<td id="tab-age-00">0명</td>
                              	</tr>
                              </table>
                             </div>
                             
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                

                <!-- Transactions -->
                <div class="col-md-6 col-lg-4 order-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between">
                      <h5 class="card-title m-0 me-2 gowun-bold">퇴사까지 평균 기간, 분포</h5>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="transactionID"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="transactionID">
                          <a class="dropdown-item" href="javascript:void(0);">Last 28 Days</a>
                          <a class="dropdown-item" href="javascript:void(0);">Last Month</a>
                          <a class="dropdown-item" href="javascript:void(0);">Last Year</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                    <div style="padding-bottom:30px;">
                      <ul class="p-0 m-0 gowun-normal" >
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/paypal.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">3개월 미만</small>
                              <h6 class="mb-0" id="mem-out-1">0<span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-1-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/wallet.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">6개월 미만</small>
                              <h6 class="mb-0" id="mem-out-2"><span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-2-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/chart.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">12개월 미만</small>
                              <h6 class="mb-0" id="mem-out-3">0<span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-3-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/cc-success.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">24개월 미만</small>
                              <h6 class="mb-0" id="mem-out-4">0<span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-4-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex mb-4 pb-1">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/wallet.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">10년 미만</small>
                              <h6 class="mb-0" id="mem-out-5">0<span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-5-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                        <li class="d-flex">
                          <div class="avatar flex-shrink-0 me-3">
                            <img src="${cPath }/resources/assets/img/icons/unicons/cc-warning.png" alt="User" class="rounded" />
                          </div>
                          <div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
                            <div class="me-2">
                              <small class="text-muted d-block mb-1">10년이상 장기근속</small>
                              <h6 class="mb-0" id="mem-out-6">0<span> 명</span></h6>
                            </div>
                            <div class="user-progress d-flex align-items-center gap-1">
                              <h6 class="mb-0" id="mem-out-6-val">0</h6>
                              <span class="text-muted"> %</span>
                            </div>
                          </div>
                        </li>
                      </ul>
                     	</div>	
                     	
                    </div>
                      <div class="p-4">
                      	<p class="mb-n1 mt-1 gowun-normal">퇴사까지 평균 기간</p>
                        <h3 class="mb-0 gowun-bold" id="mem-out-total-val">0 일</h3>
                      </div>
                  </div>
                </div>
                <!--/ Transactions -->
              </div>
              
<!-- 4번째 줄 -->
               <div class="row">
               <!-- Expense Overview -->
                <div class="col-md-6 col-lg-4 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                      <ul class="nav nav-pills" role="tablist">
                        <li class="nav-item">
                          <button
                            type="button"
                            class="nav-link active gowun-bold"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-tabs-line-card-income"
                            aria-controls="navs-tabs-line-card-income"
                            aria-selected="true"
                          >
                            	<span class="gowun-bold">급여지급</span>
                          </button>
                        </li>
                        <li class="nav-item">
                          <button type="button" class="nav-link" role="tab"></button>
                        </li>
                        <li class="nav-item">
                          <button type="button" class="nav-link" role="tab"></button>
                        </li>
                      </ul>
                    </div>
                    <div class="card-body px-0">
                      <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                          <div class="d-flex p-4 pt-3">
                            <div class="avatar flex-shrink-0 me-3">
                              <img src="${cPath }/resources/assets/img/icons/unicons/wallet.png" alt="User" />
                            </div>
                            <div>
                              <small class="text-muted d-block gowun-normal">연봉상승률</small>
                              <div class="d-flex align-items-center">
                                <h6 class="mb-0 me-1">양호</h6>
                                <small class="text-success fw-semibold">
                                  <i class="bx bx-chevron-up"></i>
                                  5.42%
                                </small>
                              </div>
                            </div>
                          </div>
                          <div id="incomeChart"></div>
<!--                           <div class="d-flex justify-content-center pt-4 gap-2"> -->
<!--                             <div class="flex-shrink-0"> -->
<!--                               <div id="expensesOfWeek"></div> -->
<!--                             </div> -->
<!--                             <div> -->
<!--                               <p class="mb-n1 mt-1">Expenses This Week</p> -->
<!--                               <small class="text-muted">$39 less than last week</small> -->
<!--                             </div> -->
<!--                           </div> -->
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
               
               
                <!-- Order Statistics -->
<!--                 <div class="col-md-6 col-lg-8 col-xl-8 order-0 mb-8"> -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">
                        <h5 class="m-0 me-2 gowun-bold">평균 근속기간 분포</h5>
                        <small class="text-muted gowun-normal">기준 : 모든기간</small>
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class=" mb-6">
                        
						<div id="serviceyearChart"></div>
                        
                      </div>
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->
              </div>
              
<!-- 5번째 즐 -->
              <div class="row">
                <!-- Order Statistics -->
<!--                 <div class="col-md-6 col-lg-8 col-xl-8 order-0 mb-8"> -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">

					
                        <h5 class="m-0 me-2 gowun-bold">조직별 인원수 및 성비</h5>
                        <small class="text-muted gowun-normal">기준 : 모든기간</small>
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class=" mb-6">
						<br>
						<div id="deptStackChart"></div>
                        
                      </div>
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->

                <!-- Expense Overview -->
                
                <div class="col-md-6 col-lg-4 order-2 mb-4">
                  <div class="card h-100">
                    
                    <div class="card-body px-0">
                      <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                          <div class="d-flex p-4 pt-3">
                            <div class="avatar flex-shrink-0 me-3">
                              <img
                                src="${cPath }/resources/assets/img/icons/unicons/chart-success.png"
                                alt="chart success"
                                class="rounded"
                              />
                            </div>
                            
                            <div class="align-items-center" style="">
                              <h5 class=" me-2 mb-0 gowun-bold">전체 구성원 성비</h5>
                              <div class="d-flex align-items-center">
                                <small class="mb-0 me-1 gowun-normal">기준 : 재직 구성원</small>
                              </div>
                            </div>
                          </div>
                          <div class="d-flex justify-content-center pt-4 gap-2">
                           	<div id="sexRatioChart"></div>
                              
                              
                            </div>
                            
                            <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
	                          <div class="d-flex">
	                            <div class="me-2">
	                              <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
	                            </div>
	                            <div class="d-flex flex-column gowun-normal">
	                              <small>남성 재직원</small>
	                              <h6 class="mb-0" id="maleMember">0명</h6>
	                            </div>
	                          </div>
	                          <div class="d-flex">
	                            <div class="me-2">
	                              <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
	                            </div>
	                            <div class="d-flex flex-column gowun-normal">
	                              <small>여성 재직원</small>
	                              <h6 class="mb-0" id="femaleMember">0명</h6>
	                            </div>
	                          </div>
	                        </div>
	                        
	                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
				
              </div>

<!-- 6번째 줄 -->
              <div class="row">
                <!-- Order Statistics -->
<!--                 <div class="col-md-6 col-lg-8 col-xl-8 order-0 mb-8"> -->
                <div class="col-18 col-lg-12 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">

					
                        <h5 class="m-0 me-2 gowun-bold">조직별 평균연봉</h5>
                        <small class="text-muted gowun-normal">기준 : 재직 구성원</small>
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class=" mb-6">
						<br>
						<div id="avgSalaryChart"></div>
                        
                      </div>
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->

              </div>
              
<!-- 7번째 줄 -->
              <div class="row">
                <!-- Order Statistics -->
<!--                 <div class="col-md-6 col-lg-8 col-xl-8 order-0 mb-8"> -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">

					
                        <h5 class="m-0 me-2 gowun-bold">평균연봉분포</h5>
                        <small class="text-muted gowun-normal">기준 : 재직 구성원</small>
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class=" mb-6">
						<br>
						<div id="salaryChart" class="card-body"></div>
                        
                      </div>
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->

                <!-- Expense Overview -->
                
                <div class="col-md-6 col-lg-4 order-2 mb-4">
                  <div class="card h-100">
                    
                    <div class="card-body px-0">
                      <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                          <div class="d-flex p-4 pt-3">
                            <div class="avatar flex-shrink-0 me-3">
                              <img
                                src="${cPath }/resources/assets/img/icons/unicons/chart-success.png"
                                alt="chart success"
                                class="rounded"
                              />
                            </div>
                            
                            <div class="align-items-center" style="">
                              <h5 class=" me-2 mb-0 gowun-bold">직위별 평균연봉</h5>
                              <div class="d-flex align-items-center">
                                <small class="mb-0 me-1 gowun-normal">기준 : 재직 구성원</small>
                              </div>
                            </div>
                          </div>
                          <div class="d-flex justify-content-center pt-4 gap-2">
                           	<div id="avgPayperPtnChart"></div>
                              
                              
                            </div>
                            
                            <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
	                          <div class="d-flex">
	                            <div class="me-2">
	                              <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
	                            </div>
	                            <div class="d-flex flex-column gowun-normal">
	                              <small>대졸 초임 평균</small>
	                              <h6 class="mb-0">3.2(백만원)</h6>
	                            </div>
	                          </div>
	                          <div class="d-flex">
	                            <div class="me-2">
	                              <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
	                            </div>
	                            <div class="d-flex flex-column gowun-normal">
	                              <small>임금상승률</small>
	                              <h6 class="mb-0">연 5.2%</h6>
	                            </div>
	                          </div>
	                        </div>
	                        
	                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
				
              </div>


<!-- 4번째 줄 -->
               <div class="row">
               <!-- Expense Overview -->
                <div class="col-md-6 col-lg-4 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                      <ul class="nav nav-pills" role="tablist">
                        <li class="nav-item">
                          <button
                            type="button"
                            class="nav-link active"
                            role="tab"
                            data-bs-toggle="tab"
                            data-bs-target="#navs-tabs-line-card-income"
                            aria-controls="navs-tabs-line-card-income"
                            aria-selected="true"
                          >
                            	연장근무
                          </button>
                        </li>
                        <li class="nav-item">
                          <button type="button" class="nav-link" role="tab">야간근무</button>
                        </li>
                        <li class="nav-item">
                          <button type="button" class="nav-link" role="tab">휴일근무</button>
                        </li>
                      </ul>
                    </div>
                    <div class="card-body px-0">
                      <div class="tab-content p-0">
                        <div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
                          <div class="d-flex p-4 pt-3">
                            <div class="avatar flex-shrink-0 me-3">
                              <img src="${cPath }/resources/assets/img/icons/unicons/wallet.png" alt="User" />
                            </div>
                            <div>
                              <small class="text-muted d-block">연장근무비율</small>
                              <div class="d-flex align-items-center">
                                <h6 class="mb-0 me-1">7명</h6>
                                <small class="text-success fw-semibold">
                                  <i class="bx bx-chevron-up"></i>
                                  11.6%
                                </small>
                              </div>
                            </div>
                          </div>
                          <div id="incomeChart"></div>
                          <div class="d-flex justify-content-center pt-4 gap-2 offcanvas-scrollvar">
                            <div class="flex-shrink-0">
                            </div>
                            <div>
                              <table class="table table-striped table-p5p2">
                              	<tr><th>연장근무자</th><th>부서</th><th>연장시간</th><th>연장사유</th></tr>
                              	<tr><td>임찬우</td><td>고객관리부</td><td>18:00 ~ 20:00</td><td>고객사 미팅 정리</td></tr>
                              	<tr><td>임지수</td><td>관리과</td><td>18:00 ~ 21:00</td><td>임금계산</td></tr>
                              	<tr><td>이주원</td><td>영업1팀</td><td>18:00 ~ 20:00</td><td>PR자료작성</td></tr>
                              	<tr><td>문효선</td><td>고객관리부</td><td>18:00 ~ 20:00</td><td>고객사 미팅 정리</td></tr>
                              	<tr><td>박상민</td><td>총무팀</td><td>18:00 ~ 20:00</td><td>월간보고자료정리</td></tr>
                              	<tr><td>김승민</td><td>IT개발팀</td><td>18:00 ~ 24:00</td><td>배포전이슈발생..</td></tr>
                              	<tr><td>장윤식</td><td>IT개발팀</td><td>18:00 ~ 20:00</td><td>배포전이슈발생..</td></tr>
                              </table>
                              
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
               
               
                <!-- Order Statistics -->
<!--                 <div class="col-md-6 col-lg-8 col-xl-8 order-0 mb-8"> -->
                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">
                        <h5 class="m-0 me-2 gowun-bold">요일별 평균 근무시간</h5>
<!--                         <small class="text-muted gowun-normal">기준 : 모든기간</small> -->
                      </div>
                      <div class="dropdown">
                        <button
                          class="btn p-0"
                          type="button"
                          id="orederStatistics"
                          data-bs-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                          <i class="bx bx-dots-vertical-rounded"></i>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
                          <a class="dropdown-item" href="javascript:void(0);">Select All</a>
                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                          <a class="dropdown-item" href="javascript:void(0);">Share</a>
                        </div>
                      </div>
                    </div>
                    <div class="card-body">
                      <div class=" mb-6">
                        
						<div id="avgWorkchart" style="width:100%;"></div>
                        
                      </div>
                      
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->
              </div>


              
              
            </div>
            <!-- / Content -->

		

</div><!-- 전체 -->


<%-- <script src="${cPath}/resources/js/insightChart.js"></script> --%>
<script src="${cPath }/resources/assets/vendor/libs/chartjs/chartjs.js"></script>
<script src="${cPath }/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>
<script>
$(".form-label").closest('.container-xxl').removeClass( 'container-xxl flex-grow-1 container-p-y' );
//================Date Picker =================================================================
	//오늘 날짜를 생성
	var date = new Date();   
	var today2 = date.toLocaleString('ko-kr');
	var year = date.getFullYear();
	var month = ('0' + (date.getMonth() + 1)).slice(-2);
	var day = ('0' + date.getDate()).slice(-2);
	var dateStr = year + '-' + month + '-' + day;

	//7일 전 날짜 및 오늘날짜를 사용하는 GMT타입으로 생성
	var before7day = new Date(date.setDate(date.getDate() - 7));	// 7일전
		let bfmonth = before7day.getMonth() + 1;
	    let bfday = before7day.getDate();
	    bfmonth = bfmonth >= 10 ? bfmonth : '0' + bfmonth;
	    bfday = bfday >= 10 ? bfday : '0' + bfday;
    var before7dayGMT = bfmonth + '/' + bfday + '/'+before7day.getFullYear() + ' GMT+9';	//7일전 (12/02/2022 GMT+9)
	var todayeGMT = month+'/'+day+'/'+year+' GMT+9';										//오늘 (12/09/2022 GMT+9)
    
// 	var empNo = $('span[id="empNm-No"]').data("empno");
// 	var empSt = $('span[id="empNm-No"]').data("empst");
	
	//태그 변수 
	var sttPrd = $("#sttPrd");
	var endPrd = $("#endPrd");
	var prRateTag = $("#prRateTag");
	var outYear = $("#outYear");
	var outRateTag = $("#outRateTag");
	var sexRatioChart = $("#sexRatioChart");
	var serviceyearChart = $("#serviceyearChart");
	var ageChart = $("#ageChart");
	var nowEmp = $("#nowEmp");
	var empRate = $("#empRate");
	
	//전역 변수
	var user = ${authEmp.empNo};
	var outdate =""
	var std = "";
	var end = "";
	var Prd1 = "";				/* 조회시작일자 */
	var Prd2 = "";				/* 조회종료일자 */
	var choosenYear = "";		/* 조회연도(퇴직률, 재직인원) */
	
	var personel = [];			/* 재직유형비율 변수 */
	var blcase = [];			/* 재직유형비율 변수 */
	
	var nowSexRatio = [];		/* 남성,여성 구성원 성비 */
	var srName = ['남성','여성'];	/* 성비 항목이름 */
	var totalMemCnt = "";		/* 구성원 총원수 */
	
	var workYear = [];			/* 구성원 재직기간 */
	var workYearName = [];		/* 구성원 재직기간명 */
	
	var ageName = [];			/* 나이분포배열 */
	var ageSpread = [];			/* 나이분포 항목이름 */
	
	var salary = [];			/* 연봉분포배열 */
	var salName = [];			/* 연봉분포 항목이름 */
	
	var waDate = [];			/* 근무일자 */
	var wkAvg = [];				/* 일별 근무시간평균 */
	var minTime = [];			/* 일별최소근무시간 */	
	var maxTime = [];			/* 일별최대근무시간 */
	
	var dnsDnm = [];			/* 부서별 성별차트 부서이름 */
	var deptEmpTotalCnt = [];	/* 부서별 성별차트 총원수 */
	var mcnt = [];				/* 부서별 성별차트 남성수 */
	var fcnt = []; 				/* 부서별 성별차트 여성수 */
	
	var dnm = [];				/* 부서별 임금정보, 부서이름 */
	var avgAmt = [];			/* 부서별 임금정보, 평균임금 */
	var minAmt = [];			/* 부서별 임금정보, 최저임금  */
	var maxAmt = [];			/* 부서별 임금정보, 최고임금  */
	var totalAvg = [];			/* 부서별 임금정보, 잔체평균임금  */
	
	var nowMemCnt =[];
	
	
//미리 선언해두는 함수----------------------------------------------------------------------------------------
	$(document).ready(function(){
		prEndRate(Prd1,Prd2);		//수습완료율 조회
		outRate(choosenYear);		//퇴직률 조회
		sexRatio();					//재직중인 구성원 성비 조회
		serviceYearRcd();			//재직중인 구성원 근속기간 조회
		memberAge();				//재직중인 구성원 나이 조회
		salaryInfo();				//재직중인 구성원 연봉분포 조회
		workTimeInfo();				//근무시간 정보 조회
		deptGenInfo();				//부서별 구성인원 성별 조회
		deptWageInfo();				//부서별 임금정보 조회
		memCnt(choosenYear);		//올해, 작년 재직총원수 조회
		prMemberInfo();				//수습중인 사원 수 조회
		outPeriodInfo();				//퇴직사원기간정보 조회
		
		
		//연도만 datepicker1-----------------------------------------
		$("#out-year-datepicker").yearpicker({
			year : 2022,
			startYear : 1950,
			endYear : 2050,
			autoclose:true
		});

		
		//연도 클릭하였을 때 실행
		$(document).on("click",".yearpicker-items",function(){
			choosenYear = $(this).text();
			
			console.log("choosenYear",choosenYear);
			toastr.info('조회연도를 변경하였습니다');
			outRate(choosenYear);	//퇴직률 조회함수
			memCnt(choosenYear);	//재직인원조회
		});//연도만 datepicker1 끝-------------------------------------
		
	
		
		// 근로유형 및 인원수 불러오기-------------------------------------
		$.ajax({
			url :  CONTEXTPATH+"/insight/chart.do",
			type : "GET",
			success : function(resp) {
				let laborCaseList = resp.laborCaseList;
				let totalMemNum =0;
				
					for(var i=0; i<laborCaseList.length; i++){
						personel.push(resp.laborCaseList[i].bfex);
						blcase.push(resp.laborCaseList[i].blCase);
					}
				console.log("위 : ",personel);
				console.log("위 : ",blcase);
				
					for(var j=0; j<laborCaseList.length; j++){
						totalMemNum += laborCaseList[j].bfex;
					}
				

					
					
				$("#mem-kind-1").text(resp.laborCaseList[5].bfex + " 명");	//정규직
				$("#mem-kind-2").text(resp.laborCaseList[6].bfex + " 명");	//기간제
				$("#mem-kind-3").text(resp.laborCaseList[2].bfex + " 명");	//파견
				$("#mem-kind-4").text(resp.laborCaseList[3].bfex + " 명");	//일용
				$("#mem-kind-5").text(resp.laborCaseList[4].bfex + " 명");	//특고
				$("#mem-kind-6").text(resp.laborCaseList[1].bfex + " 명");	//등기임원
				$("#mem-kind-7").text(resp.laborCaseList[0].bfex + " 명");	//비등기임원
				
				$("#mem-kind-1-val").text( Math.round((laborCaseList[5].bfex)/totalMemNum *100) + " %" );     //정규직   
				$("#mem-kind-2-val").text( Math.round((laborCaseList[6].bfex)/totalMemNum *100) + " %" );     //기간제   
				$("#mem-kind-3-val").text( Math.round((laborCaseList[2].bfex)/totalMemNum *100) + " %" );     //파견    
				$("#mem-kind-4-val").text( Math.round((laborCaseList[3].bfex)/totalMemNum *100) + " %" );     //일용    
				$("#mem-kind-5-val").text( Math.round((laborCaseList[4].bfex)/totalMemNum *100) + " %" );     //특고    
				$("#mem-kind-6-val").text( Math.round((laborCaseList[1].bfex)/totalMemNum *100) + " %" );     //등기임원  
				$("#mem-kind-7-val").text( Math.round((laborCaseList[0].bfex)/totalMemNum *100) + " %" );     //비등기임원
				
				$("#mem-kind-total-val").text(totalMemNum + " 명" );	//총원수
				
				
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				console.log("근로유형 및 인원수 조회 ajax 실패")
			}
		});// 근로유형 및 인원수 불러오기 끝--------------------------------
		
		
	});//----------(document).ready끝-------------------------------------------------------------------


				console.log("중간 : ", personel);
				console.log("중간 : ", blcase);
	
	
				
				
	
//연원일 daterpicker--------------------------------------------------------------------------------------
	$(function() {
		$('input[name="searchDatefilter"]').daterangepicker({
			autoUpdateInput : false,
			locale : {
				cancelLabel : 'Clear',
				format : 'YYYY-MM-DD'
			}
		});

		//DatePicker에서 날짜를 선택하여 apply한 경우 동작 (조회기간 선택해서 데이터들 변경)
		$('input[name="searchDatefilter"]').on('apply.daterangepicker',function(ev, picker) {
				std = picker.startDate.format('YYYY-MM-DD');
				end = picker.endDate.format('YYYY-MM-DD');
	
				$(this).val(
						picker.startDate.format('YYYY-MM-DD') + ' ~ '
								+ picker.endDate.format('YYYY-MM-DD'));
	
				choosenYear = picker.startDate.format('YYYY');
				console.log("datepicker 내부 choosenYear : ",choosenYear);
				
				//----------수습완료율------------------------------------------
				Prd1 = picker.startDate.format('YYYY-MM-DD');
				Prd2 = picker.endDate.format('YYYY-MM-DD');
	
				console.log("Prd1 : ", Prd1);
				console.log("Prd2 : ", Prd2);
	
				prEndRate(Prd1, Prd2); //수습완료율 조회함수
				outRate(choosenYear);	//퇴직률 조회함수
				memCnt(choosenYear);	//재직인원 조회함수
				console.log("수습완료율날짜변경");
				toastr.info('조회기간을 변경하였습니다');
				//----------수습완료율 끝------------------------------------------
		});
	
		//DatePicker에서 날짜를 선택하지 않고 cancle하였을 때 동작
		$('input[name="searchDatefilter"]').on('cancel.daterangepicker', function(ev, picker) {
			$(this).val('');
		});
	});//-------연원일 daterpicker 끝----------------------------------------------------------------------

	
//====================[차트 데이터 함수]=====================================================================
	// 재직총원수 가져오기------------------------------------------------------------------------------------
	function memCnt(choosenYear) {
		console.log("재직총원수 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/memcnt.do",
			type : "POST",
			dataType : "json",
			data : {
				selectedDate : choosenYear,
			},
			success : function(resp) {
				console.log("재직총원수 : ", resp);

				if (resp == 0 || resp == "") {
					nowEmp.text(" 0명 ");
					
					empRate.text("0%");
					
				} else {
					nowEmp.text(resp.thisEmp+" 명");
					empRate.text(resp.grwRate+" %");
					
					if(resp.grwRate >=0){
						$("#updownRate").attr('class','text-success fw-semibold');
						$("#updownArrow").attr('class','bx bx-up-arrow-alt');
					}else{
						$("#updownRate").attr('class','text-danger fw-semibold');
						$("#updownArrow").attr('class','bx bx-down-arrow-alt');
					};
					
				}
// 				
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};//------재직총원수 가져오기 끝---------------------------------------------------------------------------
	
	// 수습완료율 가져오기------------------------------------------------------------------------------------
	function prEndRate(Prd1, Prd2) {
		console.log("수습완료율 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/prRate.do",
			type : "POST",
			data : {
				prSdate : Prd1,
				prEdate : Prd2
			},
			dataType : "json",
			success : function(resp) {
				console.log("prEndRate : ", resp.prEndRate);
				console.log("성공");

				if (Prd1 == null || Prd1 == '') {
					sttPrd.text(" 모든기간 ");
					endPrd.text("");
					prRateTag.text(resp.prEndRate);
				} else {
					sttPrd.text(Prd1 + " ~ ");
					endPrd.text(Prd2);
					prRateTag.text(resp.prEndRate);
				}
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};//------수습완료율 가져오기 끝---------------------------------------------------------------------------
	
	// 퇴직률 가져오기---------------------------------------------------------------------------------------
	function outRate(choosenYear) {
		console.log("퇴직률 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/outRate.do",
			type : "POST",
			data : {
				outDate : choosenYear
			},
			dataType : "json",
			success : function(resp) {
				console.log("outRate : ", resp.outRate);
				console.log("성공");
				
				if (choosenYear == null || choosenYear == '') {
					outYear.text(choosenYear);
					outRateTag.text(resp.outRate);
				} else {
					outYear.text(choosenYear);
					outRateTag.text(resp.outRate);
				};
				
				if(resp.outRate < 0){
					$("#outUpdownRate").attr('class','text-success fw-semibold');
					$("#outUpdownArrow").attr('class','bx bx-down-arrow-alt');
					$("#outRateStat").text("퇴직률 감소");
				}else if(resp.outRate == '0%' ){
					$("#outUpdownRate").attr('class','text-warning fw-semibold');
					$("#outUpdownArrow").attr('class','bx ').text(" * ");
					$("#outRateStat").text("유지");
				}else{
					$("#outUpdownRate").attr('class','text-danger fw-semibold');
					$("#outUpdownArrow").attr('class','bx bx-up-arrow-alt');
					$("#outRateStat").text("퇴직률 증가");
				};
				
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};// 퇴직률 가져오기 끝------------------------------------------------------------------------------------

	// 수습중인 사원정보 가져오기--------------------------------------------------------------------------------
	function prMemberInfo() {
		console.log("수습중인 사원정보 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/prmember.do",
			type : "POST",
			dataType : "json",
			success : function(resp) {
				console.log("prmember : ", resp);
				console.log("성공");
				
				$("#prEmpNum").text(Object.keys(resp).length + " 명");
				//추가로 각 사원들에 대한 정보도 list로 만들어서 볼 수도 있겠습니다만
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};// 수습중인 사원정보 가져오기 끝-------------------------------------------------------------------------
	
	// 퇴직까지 기간정보 가져오기-----------------------------------------------------------------------------
	function outPeriodInfo() {
		console.log("퇴직까지 기간정보 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/outperiodinfo.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
				console.log("outperiodinfo : ", resp);
				console.log("성공");
				console.log("outperiodinfo 연습 : ",resp.avgOutPeriod);
				
				let num = 0;
				num = resp.month3 + resp.month6 + resp.month12 + resp.month24 + resp.year10 + resp.longwork;	//퇴직총원
				console.log("퇴직총원 : ",num)
				
				$("#mem-out-total-val").text(resp.avgOutPeriod);

				$("#mem-out-total-val").text(resp.avgOutPeriod);
				$("#mem-out-1").text(resp.month3 + " 명");
				$("#mem-out-2").text(resp.month6 + " 명");
				$("#mem-out-3").text(resp.month12 + " 명");
				$("#mem-out-4").text(resp.month24 + " 명");
				$("#mem-out-5").text(resp.year10 + " 명");
				$("#mem-out-6").text(resp.longwork + " 명");
				
				$("#mem-out-1-val").text(resp.month3 /num *100 );
				$("#mem-out-2-val").text(resp.month6 /num *100);
				$("#mem-out-3-val").text(resp.month12 /num *100);
				$("#mem-out-4-val").text(resp.month24 /num *100);
				$("#mem-out-5-val").text(resp.year10 /num *100);
				$("#mem-out-6-val").text(resp.longwork/num *100);
				
				
// 				$("#mem-kind-7").text(laborCaseList[0].bfex + " 명");	//비등기임원
				
// 				$("#prEmpNum").text(Object.keys(resp).length + " 명");
// 				if(resp.outRate < 0){
// 					$("#outUpdownRate").attr('class','text-success fw-semibold');
// 					$("#outUpdownArrow").attr('class','bx bx-down-arrow-alt');
// 					$("#outRateStat").text("퇴직률 감소");
// 				}else if(resp.outRate == '0%' ){
// 					$("#outUpdownRate").attr('class','text-warning fw-semibold');
// 					$("#outUpdownArrow").attr('class','bx ').text(" * ");
// 					$("#outRateStat").text("유지");
// 				}else{
// 					$("#outUpdownRate").attr('class','text-danger fw-semibold');
// 					$("#outUpdownArrow").attr('class','bx bx-up-arrow-alt');
// 					$("#outRateStat").text("퇴직률 증가");
// 				};
				
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};// 퇴직까지 기간정보 가져오기 끝-------------------------------------------------------------------------

	// 구성원 성비 가져오기---------------------------------------------------------------------------------
	function sexRatio() {
		console.log("재직중인 구성원 성비 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/sexratio.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
				console.log("sexRatioMap : ", resp);
// 				console.log("sexRatioMap TOTAL : ", resp.TOTAL);
// 				console.log("sexRatioMap FEM_CNT : ", resp.FEM_CNT);
// 				console.log("sexRatioMap MAL_CNT : ", resp.MAL_CNT);
// 				console.log("sexRatioMap FEM_RATE : ", resp.FEM_RATE);
// 				console.log("sexRatioMap MAL_RATE : ", resp.MAL_RATE);

				nowSexRatio.push(resp.MAL_CNT);
				nowSexRatio.push(resp.FEM_CNT);
				
				$("#maleMember").text(resp.MAL_CNT + " 명");
				$("#femaleMember").text(resp.FEM_CNT + " 명");
				
				totalMemCnt = resp.TOTAL;
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};// 구성원 성비 가져오기 끝------------------------------------------------------------------------------
	
	// 구성원 근속기간 가져오기-------------------------------------------------------------------------------
	function serviceYearRcd() {
		console.log("재직중인 구성원 근속기간 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/serviceyear.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
// 				workYear.push(Object.values(resp));
// 				workYearName.push(Object.keys(resp));
// 				workYear = Object.values(resp);
// 				workYearName = Object.keys(resp);

				for(var key in resp ) {
					workYearName.push(key);
					workYear.push(resp[key]);
// 				  console.log("컬럼 : " + key + " value : " + resp[key]);
				};

				console.log("workYear : ",workYear);
				console.log("workYearName : ",workYearName);
			},
			error : function(errorResp) {
				console.log("실패");
				console.log(errorResp.status);
			}
		});
	};// 구성원 근속기간 가져오기 끝----------------------------------------------------------------------------
	
	// 구성원 평균나이 가져오기-------------------------------------------------------------------------------
	function memberAge() {
		console.log("재직중인 구성원 나이 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/ageRetrieve.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
// 				ageName = Object.keys(resp);
// 				ageSpread = Object.values(resp);
				
				for(var key in resp ) {
					ageName.push(key);
					ageSpread.push(resp[key]);
				};
				
				$("#tab-age-10").text(ageSpread[0] + " 명");
				$("#tab-age-20").text(ageSpread[1] + " 명");
				$("#tab-age-30").text(ageSpread[2] + " 명");
				$("#tab-age-40").text(ageSpread[3] + " 명");
				$("#tab-age-50").text(ageSpread[4] + " 명");
				$("#tab-age-60").text(ageSpread[5] + " 명");
				
				console.log("ageName[]", ageName);
				console.log("ageSpread[]",ageSpread);
			},
			error : function(errorResp) {
				console.log("구성원 나이가져오기 실패");
				console.log(errorResp.status);
			}
		});
	};// 구성원 평균나이 가져오기 끝--------------------------------------------------------------------------
	
	// 구성원 연봉정보 가져오기-------------------------------------------------------------------------------
	function salaryInfo() {
		console.log("재직중인 구성원 연봉정보 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/salaryretrieve.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
				for(var key in resp ) {
					salName.push(key);
					salary.push(resp[key]);
				};
				console.log("연봉정보 : ", resp);
				console.log("salary []", salary );
				console.log("salName []",salName );
			},
			error : function(errorResp) {
				console.log("구성원 연봉정보가져오기 실패");
				console.log(errorResp.status);
			}
		});
	};// 구성원 연봉정보 가져오기 끝--------------------------------------------------------------------------
	
	// 근무시간(평균,최대,최소) 가져오기----------------------------------------------------------------------
	function workTimeInfo() {
		console.log("근무시간 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/worktimeaverage.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
				let varWD = resp.waDate;
				let varWA = resp.wkAvg;
				let varMNT = resp.minTime ;
				let varMXT = resp.maxTime; 
				
				console.log("근무시간 : ", resp);
				console.log("근무일자 : ", resp.waDate );
				console.log("일별 근무시간평균 : ", resp.wkAvg );
				console.log("일별 근무시간평균 values : ", Object.values(resp.wkAvg) );
				console.log("일별최소근무시간 : ", resp.minTime );
				console.log("일별최대근무시간 : ", resp.maxTime );
				
				for(var key in varWD ) {
					waDate.push(varWD[key]);
				};
				for(var key in varWA ) {
					wkAvg.push(varWA[key]);
				};
				for(var key in varMXT ) {
					maxTime.push(varMXT[key]);
				};
				for(var key in varMNT ) {
					minTime.push(varMNT[key]);
				};
			},
			error : function(errorResp) {
				console.log("근무시간 가져오기 실패");
				console.log(errorResp.status);
			}
		});
	};// 근무시간(평균,최대,최소) 가져오기 끝------------------------------------------------------------------
	
	// 부서별 구성인원 성별별 수 가져오기-----------------------------------------------------------------------
	function deptGenInfo() {
		console.log("부서별 구성인원 성별 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/sexperdept.do",
			type : "GET",
			dataType : "json",
			success : function(resp) {
				let vDnm = resp.dnm;
				let vDeptEmpTotalCnt = resp.total;
				let vMcnt = resp.mcnt ;
				let vFcnt = resp.fcnt; 
				
				console.log("부서별 구성인원 성별  : ", resp);
				console.log("부서이름 : ", vDnm );
				console.log("총원 : ", vDeptEmpTotalCnt );
				console.log("남성수 : ", vMcnt );
				console.log("여성수 : ", vFcnt );
				
				for(var key in vDnm ) {
					dnsDnm.push(vDnm[key]);
				};
				for(var key in vMcnt ) {
					mcnt.push(vMcnt[key]);
				};
				for(var key in vFcnt ) {
					fcnt.push(vFcnt[key]);
				};
			},
			error : function(errorResp) {
				console.log("부서별 구성인원 성별  가져오기 실패");
				console.log(errorResp.status);
			}
		});
	};// 부서별 구성인원 성별별 수 가져오기 끝---------------------------------------------------------------------
		
	// 부서별 임금(평균,최대,최소) 가져오기----------------------------------------------------------------------
	function deptWageInfo() {
		console.log("부서별 임금정보 출력하는 함수");
		$.ajax({
			url : CONTEXTPATH + "/insight/wageperdept.do",
			type : "GET",
			dataType : "json",
			async:false,
			success : function(resp) {
				
				let varDnm = resp.dnm;
				let varAvgAmt = resp.avgAmt;
				let varMinAmt = resp.minAmt ;
				let varMaxAmt = resp.maxAmt; 
				let varTotalAvg = resp.totalAvg;
				
				console.log("부서별 임금정보 : ", resp);
				
				for(var key in varDnm ) {
					dnm.push(varDnm[key]);
				};
				for(var key in varAvgAmt ) {
					avgAmt.push(varAvgAmt[key]);
				};
				for(var key in varMinAmt ) {
					minAmt.push(varMinAmt[key]);
				};
				for(var key in varMaxAmt ) {
					maxAmt.push(varMaxAmt[key]);
				};
				for(var key in varTotalAvg ) {
					totalAvg.push(varTotalAvg[key]);
				};
				console.log("totalAvg : ",totalAvg);
			},
			error : function(errorResp) {
				console.log("부서별 임금정보 가져오기 실패");
				console.log(errorResp.status);
			}
		});
	};// 부서별 임금(평균,최대,최소) 가져오기 끝------------------------------------------------------------------
	
	
		
//====================[차트 데이터 함수 끝]===================================================================		
		
	
	
		
		
		
//====================[차트 그리는 함수]=====================================================================
	
	//-------------------------------------------------------------꺾은선차트------------------
	var mychart = $('#lineChart');
	var myLineChart = new Chart(mychart, {
		type : 'line',
		data : {
			labels : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
					'10월', '11월', '12월' ],
			datasets : [ {
				label : '2022',
				data : [ 30, 30, 40, 41, 38, 38, 38, 40, 40, 41, 42, 38 ]
			} ]
		}
	});

	//-------------------------------------------------------------도넛차트------------------
	let data = {
		labels : [ '정규직 근로자', '기간제 근로자', '파견근로자', '일용 근로자', '특수형태근로종사자', '임원' ],
		datasets : [ {
			label : 'My First Dataset',
			data : [ 20, 4, 1, 3, 2, 5 ],
			backgroundColor : [ 'rgb(46, 184, 46)', //연두
								'rgb(153, 204, 0)', //쑥
								'rgb(255, 77, 77)', //분홍
								'rgb(128, 0, 128)', //보라
								'rgb(230, 138, 0)', //주황
								'rgb(51, 102, 255)' //파랑
								],
			hoverOffset : 4
		} ]
	};

	var pieChart = $("#pieChart");

	var myPieChart = new Chart(pieChart, {
		type : 'doughnut',
		data : data,
		options : {
			responsive : false,
			legend : {
				poition : 'bottom',
			},
			title : {
				display : true,
				text : '재직상태차트'
			},
			animation : {
				animationScale : true,
				animationRotate : false,
			}
		}
	});

	//------------------------------------------------------------------------도넛차트2
	console.log("아래 : ", personel);
	console.log("아래 : ", blcase);


	//====================근로유형 비율 도넛차트==================================================================================
	//차트옵션
	let lccOptions ={ chart : { type : 'donut' ,height : 170.55 }, /*137.55*/
					  labels : blcase, 
					  series : personel, 
					  colors : [ 'rgb(255, 80, 80)', 		//분홍
							     'rgb(255, 153, 102)', 		//주황
							     'rgb(255, 204, 0)',		//노랑
							     'rgb(77, 136, 255)',		//파랑
							     'rgb(153, 102, 255)',		//보라
							     'rgb(76, 230, 0)',			//초록
							     'rgb(0, 89, 179)'			//진파랑
							], 
					  stroke : { show : true, curve : 'straight', width : 3 },
					  dataLabels : {enabled : false, formatter : function(val, opt) { return parseInt(val, 10) + '%'; } },
					  legend : { show : false, position : 'bottom', markers : { offsetX : -3 }, itemMargin : { vertical : 3, horizontal : 10 },
								 labels : { colors : 'blue', useSeriesColors : false } },
					  plotOptions : {
								 pie : { donut : {labels : {show : true,  
									 						name : { fontSize : '0.9rem',fontFamily : 'Gowun Dodum, sans-serif',fontWeight : 'bold'},
									   						value : {  fontSize : '0.8rem', color : '#8592a3', fontFamily : 'Gowun Dodum, sans-serif', 
									   								    formatter : function(val) { return parseInt(val, 10) + '명'; }},
									   						/*total: { show: true, fontSize: '0.8rem', fontFamily : 'Gowun Dodum, sans-serif',
									   								 color: '#8592a3', label: '정규직고용률',
									   					             formatter: function (w) { return '31%'; } }*/ }}} },
					  responsive : [ { breakpoint : 992,  options : { chart : { height : 380 }, 
						  											  legend : { position : 'bottom', labels : { colors : '#8592a3', useSeriesColors : false } } } }, 
					   				 { breakpoint : 576, options : { chart : { height : 320 }, 
					   					 							 plotOptions : { pie : { donut : { labels : { show : true, 
									   								   											  name : { fontSize : '1.5rem' },
																												  value : {fontSize : '1rem' },
																												  total : {fontSize : '1.5rem' } } }}},
													   				 legend : { position : 'bottom', labels : { colors : '#8592a3', useSeriesColors : false} }}}, 
								    { breakpoint : 420, options : { chart : { height : 280 }, legend : { show : false } } }, 
								    { breakpoint : 360, options : { chart : { height : 250 }, legend : { show : false } } } ]};
	
	//옵션에 따른 차트생성 및 렌더링
	let lcDonutChart = new ApexCharts(document.querySelector("#donutChart"), lccOptions);
	lcDonutChart.render();
	//====================근로유형 비율 도넛차트 끝================================================================================
	
	//====================전체 구성원 성비 도넛차트================================================================================
	//차트옵션
	var srcOptions = {
		chart : {  type : 'donut' , height : 390,  stackType : 'normal' },
		labels : srName,
		series : nowSexRatio,
		colors : [ 'rgb(102, 153, 255)', //파랑
			       'rgb(255, 80, 80)' //분홍
		 		 ],
		stroke : { show : false, curve : 'straight' },
		dataLabels : { enabled : true, formatter : function(val, opt) { return parseInt(val, 10) + '%'; } },
		legend : { show : true, position : 'bottom', markers : { offsetX : -3 }, itemMargin : { vertical : 3, horizontal : 10 }, 
				   labels : { colors : 'blue', useSeriesColors : false } },
		plotOptions : {
			pie : { donut : {labels : {show : true,  name : { fontSize : '2rem',fontFamily : 'Gowun Dodum, sans-serif'},
									   value : {  fontSize : '1.2rem',
												  color : 'blue',
												  fontFamily : 'Gowun Dodum, sans-serif',
												  formatter : function(val) { return parseInt(val, 10) + '명'; }},
									   total: { show: true, fontSize: '1.0rem', color: "black",  label: '재직총원',  formatter: function (w) { return totalMemCnt+'명';}}}}}
		},
		responsive : [ { breakpoint : 992,  options : { chart : { height : 380 }, legend : { position : 'bottom', labels : { colors : 'blue', useSeriesColors : false } } } }, 
					   { breakpoint : 576, options : { chart : { height : 320 }, plotOptions : { pie : { donut : { labels : { show : true, 
												   								   											  name : { fontSize : '1.5rem' },
																															  value : {fontSize : '1rem' },
																															  total : {fontSize : '1.5rem' } } }}},
													   legend : { position : 'bottom', labels : { colors : 'blue', useSeriesColors : false} }}}, 
					   { breakpoint : 420, options : { chart : { height : 280 }, legend : { show : false } } }, 
					   { breakpoint : 360, options : { chart : { height : 250 }, legend : { show : false } } } ],
		tooltip: { y: { formatter: function (val) { return val + " 명" } } },
	};

	//옵션에 따른 차트생성 및 렌더링
	var srDonutChart = new ApexCharts(document.querySelector("#sexRatioChart"), srcOptions);
	srDonutChart.render();
	//====================전체 구성원 성비 도넛차트 끝==============================================================================

	//평균 근속기간 Horizontal Bar Chart =======================================================================================
  	sycOption = { chart: { height: 400, type: 'bar', toolbar: { show: false } },
    			  plotOptions: { bar: { horizontal: true, barHeight: '30%', startingShape: 'rounded', borderRadius: 8 } },
    			  grid: { borderColor: 'rgb(222,222,222)', xaxis: { lines: { show: false } }, padding: { top: -20, bottom: -12 } },
    			  colors: 'rgba(3, 195, 236, 0.85)'/*config.colors.info,*/,
    			  dataLabels: { enabled: false },
    			  series: [{ name : '인원수',data: workYear }],
			      xaxis: { categories: workYearName,
	      				   axisBorder: { show: false },
	      				   axisTicks: { show: false },
					       labels: { style: { colors: 'rgb(87, 87, 87)', fontSize: '13px' } } 
	      				  },
	    		  yaxis: { opposite:true,labels: { style: { colors: 'rgb(87, 87, 87)', fontSize: '13px', fontFamily : 'Gowun Dodum, sans-serif'},  }, },
	    		  tooltip: { y: { formatter: function (val) { return val + " 명" } } },};
	
  	//옵션에 따른 차트생성 및 렌더링
	var syHorBarChart = new ApexCharts(document.querySelector("#serviceyearChart"), sycOption);
	syHorBarChart.render();
	//평균 근속기간 Horizontal Bar Chart 끝 =====================================================================================
	
	//평균 나이분포 pie Chart ==================================================================================================
	 var memCompOptions = { series: ageSpread, chart: { width: 380, type: 'pie', },
        					colors : ['#8c8c8c','#ff3e1d','rgb(3, 195, 236)','rgb(105, 108, 255)','rgb(113, 221, 55)','#ffab00','#0059b3',],
        					labels: ageName,
        					responsive: [{ breakpoint: 480, options: { chart: { width: 200 }, legend: { position: 'bottom' } } }],
        					tooltip: { y: { formatter: function (val) { return val + " 명" } } },
	 					  };

        var memCompChart = new ApexCharts(document.querySelector("#memCompChart"), memCompOptions);
        memCompChart.render();
      //평균 나이분포 pie Chart 끝 ==============================================================================================

    	  
	//연봉분포  Vertical Bar Chart(column chart)===============================================================================
    var salChOptions = { series: [{ name: '인원수', data: salary  }],
         			   chart: { type: 'bar', height: 350, stacked: true, toolbar: { show: true }, zoom: { enabled: true } },
        			   responsive: [{ breakpoint: 480, options: { legend: { position: 'bottom', offsetX: -10, offsetY: 0 } } }],
        			   plotOptions: { bar: { columnWidth: '20%', horizontal: false, borderRadius: 10, 
        				   				  	 dataLabels: { total: { enabled: true, style: { fontSize: '13px', fontWeight: 900 } } } } },
        			   xaxis: { /*type: 'datetime',*/ categories: salName , },
			           legend: { position: 'right', offsetY: 40 },
        			   fill: { opacity: 1 },
        			   tooltip: { y: { formatter: function (val) { return val + " 명" } } },
       				 };
    
 	 //옵션에 따른 차트생성 및 렌더링
     var salaryChart = new ApexCharts(document.querySelector("#salaryChart"), salChOptions);
     salaryChart.render();
    //연봉분포  Vertical Bar Chart(column chart) 끝=============================================================================
    	
	//요일별 평균근무시간,최소, 최대근무시간  Vertical Bar Chart(column chart)+linechart===============================================
	    var avwOptions = { series: [{ name: '일평균근무시간',type: 'column', data:wkAvg   }, {name: '일최고근무시간', type: 'line', data: maxTime}
	    							, {name: '일최소근무시간', type: 'line', data: minTime} ],
	         			   chart: { type: 'line', height: 350, /*stacked: true,*/ toolbar: { show: true }, zoom: { enabled: true },
	         				  locales : [{"name": "ko", "options": { "months": [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		         					      "shortMonths": [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		         					      "days": [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
		         					      "shortDays": ["일", "월", "화", "수", "목", "금", "토"],
		         					      "toolbar": { "exportToSVG": "SVG 다운로드", "exportToPNG": "PNG 다운로드", "exportToCSV": "CSV 다운로드", "menu": "메뉴", 
		         					      "selection": "선택", "selectionZoom": "선택영역 확대", "zoomIn": "확대", "zoomOut": "축소", "pan": "패닝", "reset": "원래대로" } } }],
	         			   	  defaultLocale : 'ko',
	         			   },
	        			   responsive: [{ breakpoint: 480, options: { legend: { position: 'bottom', offsetX: -10, offsetY: 0 } } }],
	        			   plotOptions: { bar: { columnWidth: '20%', horizontal: false, borderRadius: 10, 
	        				   				  	 dataLabels: { total: { enabled: true, style: { fontSize: '13px', fontWeight: 900 } } } } },
// 	        			   title: { text: '요일별 평균 근무시간 및 최대,최소 근무시간'},
	        			   colors: ['rgba(105, 108, 255, 0.85)', 'rgba(3, 195, 236, 0.85)','rgb(113, 221, 55)'],
	        			   stroke: {curve: 'smooth'},
	        			   dataLabels: { enabled: true, enabledOnSeries: [1,2] },
// 	        			   yaxis: [{ title: { text: '시간(Hour)', }, color : '#8c8c8c', }],
	        			   xaxis: { type: 'datetime',
	        				   		categories: waDate ,
	        				   		labels : {
	        				   			datetimeFormatter: {
	        				                day: 'yy-MM-dd',
	        				            }
	        				   		}
	        				   	},
				           legend: { position: 'right', offsetY: 40, fontFamily : 'Gowun Dodum, sans-serif' },
	        			   fill: { opacity: 1 },
	        			   tooltip: { y: { formatter: function (val) { return val + " 시간" } },  x: { show: true, format: 'MMM dd', formatter: undefined, }, },
        				 };
        var avgWorkchart = new ApexCharts(document.querySelector("#avgWorkchart"), avwOptions);
        avgWorkchart.render();	
// 	});

    //요일별 평균근무시간,최소, 최대근무시간  Vertical Bar Chart(column chart)+linechart 끝=============================================

		
	//부서별 인원수 및 성비 Stacked Bar Chart =====================================================================================
		 var deptsStackOptions = {
         	series: [{ name: '남성 구성원', data: mcnt }, 
         			 { name: '여성 구성원', data: fcnt },],
          	chart: { type: 'bar', height: 350, stacked: true, },
        	plotOptions: { bar: { horizontal: true, dataLabels: { total: { enabled: true, offsetX: 0, style: { fontSize: '13px', fontWeight: 900, fontFamily : 'Gowun Dodum, sans-serif' } } } }, },
        	stroke: { width: 1, colors: ['#fff'] },
//         	title: { text: '조직별 구성원수 및 성비' },
        	xaxis: { categories: dnsDnm, labels: { formatter: function (val) { return val + "명" } },fontFamily : 'Gowun Dodum, sans-serif' },
//         	yaxis : {fontFamily : 'Gowun Dodum, sans-serif'},
        	tooltip: { y: { formatter: function (val) { return val + "명" } } },
        	fill: { opacity: 1 },
	        legend: {
	          position: 'top',
	          horizontalAlign: 'left',
	          offsetX: 40,
	          fontFamily : 'Gowun Dodum, sans-serif',
	        }
	        };

        var dscChart = new ApexCharts(document.querySelector("#deptStackChart"), deptsStackOptions);
        dscChart.render();
		
	//부서별 인원수 및 성비 Stacked Bar Chart 끝====================================================================================
		
	//부서별 평균연봉 column + line Chart ========================================================================================
	  var depAvgSalOptions = { series: [{ name: '부서평균연봉',type: 'column', data:avgAmt   }, {name: '최고연봉', type: 'line', data: maxAmt}
							, {name: '최소연봉', type: 'line', data: minAmt} ],
							   chart: { type: 'line', height: 350, /*stacked: true,*/ toolbar: { show: true }, zoom: { enabled: true }},
							   responsive: [{ breakpoint: 480, options: { legend: { position: 'bottom', offsetX: 0, offsetY: 0 } } }],
							   plotOptions: { bar: { columnWidth: '50%', horizontal: false, borderRadius: 10, 
								   				  	 dataLabels: { total: { enabled: true, style: { fontSize: '13px', fontWeight: 900, fontFamily : 'Gowun Dodum, sans-serif' } } } } },
// 							   title: { text: '부서별 평균 연봉 및 최고,최소 연봉'},
							   colors: ['rgba(105, 108, 255, 0.85)', 'rgba(3, 195, 236, 0.85)','#ff9900'],
							   annotations: { yaxis: [{ y: totalAvg , borderColor: '#00E396', label: { borderColor: '#00E396',
								   			  style: { color: '#fff', background: '#00E396' }, text: '구성원 전체 평균연봉' } } ] },
							   stroke: {curve: 'smooth'},
							   dataLabels: { enabled: true, enabledOnSeries: [1,2], formatter: function (val, opts) { return val  },},
							   yaxis: [{ title: { text: '(백)만원', } }],
							   xaxis: { type: 'category',
			   				   categories: dnm ,
//			   		min : before7dayGMT, max : todayeGMT, range : 7, labels:{ show:true, }, axisBorder:{ width:'100%', }, axisTicks:{ show : true,}
			   				   },
			   	
       						   legend: { position: 'right', offsetY: 40 },
		   					   fill: { opacity: 1 },
		   					   tooltip: { y: { formatter: function (val) { return val + " 백만원" } } },
		 };


        var depAvgSalChart = new ApexCharts(document.querySelector("#avgSalaryChart"), depAvgSalOptions);
        depAvgSalChart.render();	
        
	//부서별 평균연봉 column + line Chart 끝========================================================================================
		//부서별 최고연봉금액, 최저연봉금액, 평균연봉금액
		
		avgPayperPtnChart
		//직위별 평균연봉
		var apptnChartOptions = {
				series: [{
			          name: '평균연봉',
			          data: [2.8, 3.1, 4.0, 5.5, 7.2, 3.6, 4.6, 6.0, 7.7, 8.0, 10.1]
			        }],
			          chart: {
			          height: 350,
			          type: 'bar',
			        },
			        plotOptions: {
			          bar: {
			            borderRadius: 10,
			            dataLabels: {
			              position: 'top', // top, center, bottom
			            },
			          }
			        },
			        dataLabels: {
			          enabled: true,
			          formatter: function (val) {
			            return val + "";
			          },
			          offsetY: -20,
			          style: {
			            fontSize: '12px',
			            colors: ["#304758"]
			          }
			        },
			        
			        xaxis: {
			          categories: ["사원", "대리", "과장", "차장", "부장", "주임", "선임", "책임", "수석", "지부장", "임원"],
			          position: 'top',
			          axisBorder: {
			            show: false
			          },
			          axisTicks: {
			            show: false
			          },
			          crosshairs: {
			            fill: {
			              type: 'gradient',
			              gradient: {
			                colorFrom: '#D8E3F0',
			                colorTo: '#BED1E6',
			                stops: [0, 100],
			                opacityFrom: 0.4,
			                opacityTo: 0.5,
			              }
			            }
			          },
			          tooltip: {
			            enabled: true,
			          }
			        },
			        yaxis: {
			          axisBorder: {
			            show: false
			          },
			          axisTicks: {
			            show: false,
			          },
			          labels: {
			            show: false,
			            formatter: function (val) {
			              return val + "백만원";
			            }
			          }
			        
			        },
			        /*title: {
			          text: ', 직위별2002',
			          floating: true,
			          offsetY: 330,
			          align: 'center',
			          style: {
			            color: '#444'
			          }
			        }*/
        };

        var apptnChart = new ApexCharts(document.querySelector("#avgPayperPtnChart"), apptnChartOptions);
        apptnChart.render();
		
		
		
	//========================================================================================================================
	
	
	 //toastr 옵션 설정
	 	
	/* error빨강, warning노랑, succeess초록, info파랑 */
	// 		toastr.success('인사정보를 수정하였습니다');
	toastr.options = {
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-top-center",		// 위치설정 : 중앙 가운데
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "100",					//나타나는 시간 : 100ms
	  "hideDuration": "1000",					//사라지는 시간 : 1000ms
	  "timeOut": "1000",						//유지시간 : 1000ms
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	};
	
	
	//변경함
	//평균 나이분포 Horizontal Bar Chart =======================================================================================
	 acOption = { chart: { height: 400, type: 'bar', toolbar: { show: false } },
	    			plotOptions: { bar: { horizontal: true, barHeight: '30%', startingShape: 'rounded', borderRadius: 8 } },
	    			grid: { borderColor: 'rgb(222,222,222)', xaxis: { lines: { show: false } }, padding: { top: -20, bottom: -12 } },
	    			colors: 'rgb(0,255,255)',
	    			dataLabels: { enabled: false },
	    			series: [{ name : '인원수',data: ageSpread  }],
				    xaxis: { categories: ageName ,
	      					 axisBorder: { show: false },
	      					 axisTicks: { show: false },
					         labels: { style: { colors: 'rgb(87, 87, 87)', fontSize: '13px' } } 
	      				    },
	    			yaxis: { labels: { style: { colors: 'rgb(87, 87, 87)', fontSize: '13px'}} },
	    			
	  			  };

	//옵션에 따른 차트생성 및 렌더링
// 	var ageHorBarChart = new ApexCharts(document.querySelector("#"), acOption);
// 	ageHorBarChart.render();
	//평균 나이분포 Horizontal Bar Chart 끝 =====================================================================================
	
</script>