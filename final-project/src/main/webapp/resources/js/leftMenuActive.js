 let hostIndex = location.href.indexOf( location.host ) + location.host.length;
 let menuUrl = location.href.substring( location.href.indexOf('/', hostIndex + 1) );
 console.log(menuUrl);
 $('.menu-item').each(function(){
	 let menudata = $(this).data('menu')
		switch(menuUrl){
			//######################################################
			// 근무
			case '/work/myWork.do':
				if(menudata == 'work') $(this).addClass('active');
				break;
			case '/work/members.do':
				if(menudata == 'work') $(this).addClass('active');
				break;
			//######################################################
			// 홈피드
			case '/home/feed.do':
				if(menudata == 'home') $(this).addClass('active');
				break;
			case '/notice/noticeList.do':
				if(menudata == 'home') $(this).addClass('active');
				break;
			case '/home/todo/inbox.do':
				if(menudata == 'home') $(this).addClass('active');
				break;
			//######################################################
			// 인사
			case '/emp/empList.do':
				if(menudata == 'emp') $(this).addClass('active');
				break;
			case '/emp/empTable.do':
				if(menudata == 'emp') $(this).addClass('active');
				break;
			case '/emp/cntStatusList.do':
				if(menudata == 'emp') $(this).addClass('active');
				break;
			case '/emp/empTransferList.do':
				if(menudata == 'emp') $(this).addClass('active');
				break;
			//######################################################
			// 휴가
			case '/myVacation/vacOutlineView.do':
				if(menudata == 'vac') $(this).addClass('active');
				break;
			case '/myVacation/annualVacDetailView.do':
				if(menudata == 'vac') $(this).addClass('active');
				break;
			case '/memberVacation/vacPosnStatView.do':
				if(menudata == 'vac') $(this).addClass('active');
				break;
			case '/memberVacation/vacAplyHistoryView.do':
				if(menudata == 'vac') $(this).addClass('active');
				break;
			//######################################################
			// 인사이트
			case '/insight/main.do':
				if(menudata == 'insight') $(this).addClass('active');
				break;
			//######################################################
			// 문서증명서
			case '/cerf/myCerf.do':
				if(menudata == 'cerf') $(this).addClass('active');
				break;
			case '/cerf/empCerf.do':
				if(menudata == 'cerf') $(this).addClass('active');
				break;
			//######################################################
			// 설정
			case '/setting/main.do':
				if(menudata == 'setting') $(this).addClass('active');
				break;
			case '/setting/workSet.do':
				if(menudata == 'setting') $(this).addClass('active');
				break;
			case '/vacationConfig/vacConfigView.do':
				if(menudata == 'setting') $(this).addClass('active');
				break;
			//######################################################
			// 급여
			case '/pay/paystub.do':
				if(menudata == 'payStub') $(this).addClass('active');
				break;
			//######################################################
			// 급여정산
			case '/pay/payHome.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/pastPayroll.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/tmpList.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/tmpInsert.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/tmpUpdate.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/servList.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/cerfList.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/withhold.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/wageEmp.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/wagePay.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/wageDed.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/wagePrev.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
			case '/pay/wageRes.do':
				if(menudata == 'payHome') $(this).addClass('active');
				break;
		}
	});