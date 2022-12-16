<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.13.1/af-2.5.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/b-print-2.3.3/cr-1.6.1/date-1.2.0/fc-4.2.1/fh-3.3.1/kt-2.8.0/r-2.4.0/rg-1.3.0/rr-1.3.1/sc-2.0.7/sb-1.4.0/sp-2.1.0/sl-1.5.0/sr-1.2.0/datatables.min.css"/>
 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.13.1/af-2.5.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/b-print-2.3.3/cr-1.6.1/date-1.2.0/fc-4.2.1/fh-3.3.1/kt-2.8.0/r-2.4.0/rg-1.3.0/rr-1.3.1/sc-2.0.7/sb-1.4.0/sp-2.1.0/sl-1.5.0/sr-1.2.0/datatables.min.js"></script>

<script>
$(document).ready( function () {
    $('#myServTable').DataTable();
} );
</script>
    
    퇴직금 리스트 조회
    
    <span class="badge bg-label-primary me-1">1년 이상</span>
	<span class="badge bg-label-warning me-1">1년 미만</span>
	<span class="badge bg-label-info me-1">정년퇴직</span>
  
<div class="card-datatable table-responsive pt-0">
  <table id="myServTable" class="datatables-basic table border-top">
    <thead>
      <tr>
        <th></th>
        <th></th>
        <th>id</th>
        <th>이름</th>
        <th>사번</th>
        <th>입사일</th>
        <th>퇴직일</th>
        <th>퇴직급여유형</th>
        <th>연금운용사</th>
        <th>계좌번호</th>
        <th>정산대상여부</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
    	<tr>
    		<td>1</td>
    		<td>2</td>
    		<td>3</td>
    		<td>4</td>
    		<td>5</td>
    		<td>6</td>
    		<td>7</td>
    		<td>8</td>
    		<td>9</td>
    		<td>10</td>
    		<td>11</td>
    		<td>12</td>
    	</tr>
    </tbody>
  </table>
</div>
  

<script>
var data=[];
var deptArr=[];

$.ajax({
	url : "${cPath}/pay/servList.do",
	method : "GET",
	dataType : "JSON",
	success : function(resp) {
		$(resp.empList).each(function(index, emp){
			var temp_psCase="";
			var temp_psSdate="";
			var temp_psBank="";
			var temp_psAcnt="";
			
			var object = {};
			object["id"]=emp.empNo;
			
			if(!emp.empImg){
				object["avatar"]='${cPath}/resources/images/basicProfile.png';
				
			}else{
				object["avatar"]='${cPath}/resources/empImages/'+emp.empImg;
			}
			
			object["이름"]=emp.empNm;
			
			if(!emp.deptFlow){
				object["post"] = "";
			}else{
				deptArr = emp['deptFlow'].split('>');
				object["post"] = deptArr[deptArr.length - 1];
				
			}
			
			object["사번"]=emp.empNo;
			object["city"]="";
			object["입사일"]=emp.entDate;
			object["퇴직일"]=emp.outDate;
			object["age"]="";
			object["experience"]="";
			object["정산대상여부"]=emp.empSt;

			$(resp.pensionList).each(function(index, pension){
				if(emp.empNo == pension.psEmpno && pension.psCase!=null){
					temp_psCase = pension.psCase;
				}else{
					temp_psCase += "";
				}
			})
			$(resp.pensionList).each(function(index, pension){
				if(emp.empNo == pension.psEmpno && pension.psSdate!=null){
					temp_psSdate = pension.psSdate;
				}else{
					temp_psSdate += "";
				}
			})
			$(resp.pensionList).each(function(index, pension){
				if(emp.empNo == pension.psEmpno && pension.psBank!=null){
					temp_psBank = pension.psBank;
				}else{
					temp_psBank += "";
				}
			})
			$(resp.pensionList).each(function(index, pension){
				if(emp.empNo == pension.psEmpno && pension.psAcnt!=null){
					temp_psAcnt = pension.psAcnt;
				}else{
					temp_psAcnt += "";
				}
			})
			

			object["연금운용사"]=temp_psBank;
			object["계좌번호"]=temp_psAcnt;
			object["퇴직급여유형"]=temp_psCase;
			
			data.push(object);
		});
		console.log("data확인",data);
	},
	error : function(errorResp) {
		console.log(errorResp.status);
	}
});


$(function() {
  'use strict';

  var dt_basic_table = $('.datatables-basic');

  // DataTable with buttons
  // --------------------------------------------------------------------

  if (dt_basic_table.length) {
    var dt_basic = dt_basic_table.DataTable({
      data:data,
      destroy: true,
      columns: [
        { data: '' },
        { data: 'id' },
        { data: 'id' },
        { data: '이름' },
        { data: '사번' },
        { data: '입사일' },
        { data: '퇴직일' },
        { data: '퇴직급여유형' },
        { data: '연금운용사' },
        { data: '계좌번호' },
        { data: '정산대상여부' },
        { data: '' }
      ],
      columnDefs: [
        {
          // For Responsive
          className: 'control',
          orderable: false,
          responsivePriority: 2,
          searchable: false,
          targets: 0,
          render: function(data, type, full, meta) {
            return '';
          }
        },
        {
          // For Checkboxes
          targets: 1,
          orderable: false,
          responsivePriority: 3,
          searchable: false,
          checkboxes: true,
          render: function() {
            return '<input type="checkbox" class="dt-checkboxes form-check-input">';
          },
          checkboxes: {
            selectAllRender: '<input type="checkbox" class="form-check-input">'
          }
        },
        {
          targets: 2,
          searchable: false,
          visible: false
        },
        {
          // Avatar image/badge, Name and post
          targets: 3,
          responsivePriority: 4,
          render: function(data, type, full, meta) {
            var $user_img = full['avatar'],
              $name = full['이름'],
              $post = full['post'];
            if ($user_img) {
              // For Avatar image
              var $output =
            	  
                '<img src="' + $user_img + '" alt="Avatar" class="rounded-circle">';
            } else {
              // For Avatar badge
              var stateNum = Math.floor(Math.random() * 6);
              var states = ['success', 'danger', 'warning', 'info', 'dark', 'primary', 'secondary'];
              var $state = states[stateNum],
                $name = full['이름'],
                $initials = $name.match(/\b\w/g) || [];
              $initials = (($initials.shift() || '') + ($initials.pop() || '')).toUpperCase();
              $output = '<span class="avatar-initial rounded-circle bg-label-' + $state + '">' + $initials + '</span>';
            }
            // Creates full output for row
            var $row_output =
              '<div class="d-flex justify-content-start align-items-center">' +
              '<div class="avatar-wrapper">' +
              '<div class="avatar me-2">' +
              $output +
              '</div>' +
              '</div>' +
              '<div class="d-flex flex-column">' +
              '<span class="emp_name text-truncate">' +
              $name +
              '</span>' +
              '<small class="emp_post text-truncate text-muted">' +
              $post +
              '</small>' +
              '</div>' +
              '</div>';
            return $row_output;
          }
        },
        {
          responsivePriority: 1,
          targets: 4
        },
        {
          // Label
          targets: -2,
          render: function(data, type, full, meta) {
            var $status_number = full['정산대상여부'];
            var $status = {
              재직중: { title: '재직중', class: 'bg-label-primary' },
              퇴직: { title: '퇴직', class: ' bg-label-success' },
              3: { title: 'Rejected', class: ' bg-label-danger' },
              4: { title: 'Resigned', class: ' bg-label-warning' },
              5: { title: 'Applied', class: ' bg-label-info' }
            };
            if (typeof $status[$status_number] === 'undefined') {
              return data;
            }
            return (
              '<span class="badge rounded-pill ' +
              $status[$status_number].class +
              '">' +
              $status[$status_number].title +
              '</span>'
            );
          }
        },
        {
          // Actions
          targets: -1,
          title: 'Actions',
          orderable: false,
          searchable: false,
          render: function(data, type, full, meta) {
            return (
              '<div class="d-inline-block">' +
              '<a href="javascript:;" class="btn btn-sm text-primary btn-icon dropdown-toggle hide-arrow" data-bs-toggle="dropdown"><i class="bx bx-dots-vertical-rounded"></i></a>' +
              '<ul class="dropdown-menu dropdown-menu-end">' +
              '<li><a href="javascript:;" class="dropdown-item">Details</a></li>' +
              '<li><a href="javascript:;" class="dropdown-item">Archive</a></li>' +
              '<div class="dropdown-divider"></div>' +
              '<li><a href="javascript:;" class="dropdown-item text-danger delete-record">Delete</a></li>' +
              '</ul>' +
              '</div>' +
              '<a href="javascript:;" class="btn btn-sm text-primary btn-icon item-edit"><i class="bx bxs-edit"></i></a>'
            );
          }
        }
      ],
      order: [[2, 'desc']],
      dom:
        '<"card-header"<"head-label text-center"><"dt-action-buttons text-end"B>><"d-flex justify-content-between align-items-center row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>t<"d-flex justify-content-between row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
      displayLength: 7,
      lengthMenu: [7, 10, 25, 50, 75, 100],
      buttons: [
        {
          extend: 'collection',
          className: 'btn btn-label-primary dropdown-toggle me-2',
          text: '<i class="bx bx-show me-2"></i>Export',
          buttons: [
            {
              extend: 'print',
              text: '<i class="bx bx-printer me-2" ></i>Print',
              className: 'dropdown-item',
              exportOptions: { columns: [3, 4, 5, 6, 7,8,9,10] }
            },
            {
              extend: 'csv',
              text: '<i class="bx bx-file me-2" ></i>Csv',
              className: 'dropdown-item',
              exportOptions: { columns: [3, 4, 5, 6, 7,8,9,10] }
            },
            {
              extend: 'excel',
              text: 'Excel',
              className: 'dropdown-item',
              exportOptions: { columns: [3, 4, 5, 6, 7,8,9,10] }
            },
            {
              extend: 'pdf',
              text: '<i class="bx bxs-file-pdf me-2"></i>Pdf',
              className: 'dropdown-item',
              exportOptions: { columns: [3, 4, 5, 6, 7,8,9,10] }
            },
            {
              extend: 'copy',
              text: '<i class="bx bx-copy me-2" ></i>Copy',
              className: 'dropdown-item',
              exportOptions: { columns: [3, 4, 5, 6, 7,8,9,10] }
            }
          ]
        },
        {
          text: '<i class="bx bx-plus me-2"></i> <span class="d-none d-lg-inline-block">Add New Record</span>',
          className: 'create-new btn btn-primary'
        }
      ],
      responsive: {
        details: {
          display: $.fn.dataTable.Responsive.display.modal({
            header: function(row) {
              var data = row.data();
              return 'Details of ' + data['이름'];
            }
          }),
          type: 'column',
          renderer: function(api, rowIdx, columns) {
            var data = $.map(columns, function(col, i) {
              return col.title !== '' // ? Do not show row in modal popup if title is blank (for check box)
                ? '<tr data-dt-row="' +
                    col.rowIndex +
                    '" data-dt-column="' +
                    col.columnIndex +
                    '">' +
                    '<td>' +
                    col.title +
                    ':' +
                    '</td> ' +
                    '<td>' +
                    col.data +
                    '</td>' +
                    '</tr>'
                : '';
            }).join('');

            return data ? $('<table class="table"/><tbody />').append(data) : false;
          }
        }
      }
        
    });
    $('div.head-label').html('<h5 class="card-title mb-0">DataTable with Buttons</h5>');
  }
});


</script>