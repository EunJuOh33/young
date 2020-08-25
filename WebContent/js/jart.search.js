(function($) {

	$.jart = $.jart || {};
	$.jart.search = $.jart.search || {};
	$.jart.search.index = $.jart.search.index || {};
	$.jart.search.result = $.jart.search.result || {};
	$.jart.search.result.allList = $.jart.search.result.allList || {};
	$.jart.search.result.revwList = $.jart.search.result.revwList || {};
	$.jart.search.result.photoList = $.jart.search.result.photoList || {};
	$.jart.search.result.prdList = $.jart.search.result.prdList || {};
	
	$.jart.prd = $.jart.prd || {};
	$.jart.prd.revw = $.jart.prd.revw || {};
	
	var $reviewGrid = undefined;
	
	var searchOptions = {
		searchValue : '',
		pageNumber : 1,
		rows : 10,
		sortOption : null
	}
	
	var jsRenderFnc = {
		addComma : $.ib.addComma,
		isSoldout : function(stk_qty,safe_stk_qty,sal_qty){
			return (stk_qty - sal_qty) <= safe_stk_qty;
		},
		getCodeText : function(cd,obj){
			return obj[cd]
		},
		subString :  $.ib.substring,
		toDate : $.ib.date.toDate,
		replaceNBSP : function(value){
			return value.replace(/&amp;nbsp;/g, " ").replace(/&amp;nbsp/g, " ");
		},		
		evltItemValue : function(value){
			var number = typeof(value) === 'string' ? Number(value) : value;
			var surplus = number % 20;
			return (number - surplus) / 20;
		}
	};
	
	$.jart.search.index.setIndex = function(){
		var $container = $('#container'); 
		
		var poplrData= $.dr.search.poplr.getList();//인기검색어
		var rcmnData = $.dr.search.rcmn.getList();//추천 검색어
		
		$.when(poplrData,rcmnData)
		.done(function(poplrList,rcmnList){
			if(poplrList.status === 200 && rcmnList.status === 200){
				var poplr = poplrList.list;
				var rcmn = rcmnList.list;
				//인기 검색어
				if(poplr.length > 0){
					$('.rolling',$container).html($('#poplrListItemTemplate').render({
						list : poplr
					}));
				}else{
					$('.schKeyword',$container).hide();
				}
				//추천 검색어
				if(rcmn.length > 0){
					$('#inputText').attr('placeholder',rcmn[0].srchw_ko_nm);
				}
				
				$.jart.search.index.setIndex.addEvent(rcmn.length);
			}else{
				$('.schKeyword',$container).hide();
				$.jart.search.index.setIndex.addEvent(0);
			}
		});
	};
	
	$.jart.search.index.setIndex.addEvent = function(rcmnKeyword){
		var $container = $('#container'); 
		//인기 검색어 rolling 적용 스크립트 S
		var _rollingH = $("html, boby").height() - ($(".topGnb").outerHeight() + $(".maxContents").outerHeight() + 120);
		
		$('.schRolling .rolling',$container).slick({
			dots: false,
			arrows: false,
			vertical: true,
			speed: 1000,
			autoplay: true,
			autoplaySpeed: 500,
			cssEase: 'ease-in-out',
			centerMode:true,
			slidesToShow: 5,
			slidesToScroll: 1,
			pauseOnFocus: false,
			verticalSwiping: true
		}).on("mousewheel", function (event) {
	        event.preventDefault();
	        //$(this).slick('slickSetOption', 'speed', 500, true);
			if (event.deltaX > 0 || event.deltaY < 0) {
				$(this).slick('slickNext');
			} else if (event.deltaX < 0 || event.deltaY > 0) {
				$(this).slick('slickPrev');
			}
	        //$(this).slick('slickSetOption', 'speed', 1000, true);
		});
		
		$(".schKeyword",$container).css("height", _rollingH );
		$(".schKeyword .schRolling .rolling",$container).css("height", _rollingH );
		
		$(window).resize(function(){
			$(".schKeyword",$container).css("height", _rollingH );
			$(".schKeyword .schRolling .rolling",$container).css("height", _rollingH );
		});
		//인기 검색어 rolling 적용 스크립트 E
		
		//인기 검색어 클릭
		$('.schRolling .rolling a',$container).on('click',function(){
			location.href = $.context + '/ko/search/result?searchValue=' + encodeURIComponent($(this).data('poplrtext'));	
		});
		
		
		$('.unifiedSch a',$container).on('click',function(){
			var searchValue = $('#inputText').val();
			var tempsearchValue = searchValue.replace(/(\s*)/g, "");
			var rcmnText = $('#inputText').attr('placeholder');
			var tempRcmnText = rcmnText.replace(/(\s*)/g, "");
			
			
			if(tempsearchValue.length > 0){
				location.href = $.context + '/ko/search/result?searchValue=' + encodeURIComponent(searchValue);	
			}else if(rcmnKeyword > 0 && tempRcmnText.length > 0){
				location.href = $.context + '/ko/search/result?searchValue=' + encodeURIComponent(rcmnText);
			}else{
				showLayerAlert('검색어를 입력해주시기 바랍니다.');	
			}			
		});
		
	};
	
	$.jart.search.result.setRcmn = function(){
		var $container = $('#container'); 

		var rcmnData = $.dr.search.rcmn.getList();//추천 검색어
		var skinTypeCdData = $.dr.cd.dtl.getList($.jart.prd.revw.skinTypeCd); 
		var skinWoryCdData = $.dr.cd.dtl.getList($.jart.prd.revw.skinWoryCd);
		
		$.when(rcmnData,skinTypeCdData,skinWoryCdData)
		.done(function(rcmnList,skinTypeCd,skinWoryCd){
			if(rcmnList.status === 200 && skinTypeCd.status === 200 && skinWoryCd.status === 200){
				var rcmn = rcmnList.list;
				
				$.jart.prd.revw.cds = {
					skinTypeCd : skinTypeCd.list,
					skinWoryCd : skinWoryCd.list
				}
				
				//추천 검색어
				if(rcmn.length > 0){
					$('#inputText').attr('placeholder',rcmn[0].srchw_ko_nm);
				}
				
				$.jart.search.result.setRcmn.addEvent(rcmn.length);
			}else{
				$.jart.search.result.setRcmn.addEvent(0);
			}
		});
	};
	
	$.jart.search.result.setRcmn.addEvent = function(rcmnKeyword){
		var $container = $('#container'); 
		
		$('#inputText').on('keypress',function(event){
			  if(event.keyCode == 13){
				  $('.unifiedSch a',$container).trigger('click');
			  }
		});
		
		$('.unifiedSch a',$container).on('click',function(){
			var searchValue = $('#inputText').val();
			var tempsearchValue = searchValue.replace(/(\s*)/g, "");
			var rcmnText = $('#inputText').attr('placeholder');
			var tempRcmnText = rcmnText.replace(/(\s*)/g, "");
						
			if(tempsearchValue.length > 0){
				delete searchOptions.sortOption;
				searchOptions.searchValue = searchValue;
				$.jart.search.result.allList.setList();
			}else if(rcmnKeyword > 0 && tempRcmnText.length > 0){
				delete searchOptions.sortOption;
				searchOptions.searchValue = rcmnText;
				$.jart.search.result.allList.setList();
			}else{
				showLayerAlert('검색어를 입력해주시기 바랍니다.');	
			}			

		});
		$('.unifiedSch a',$container).trigger('click');
	};
		
	$.jart.search.result.allList.setList = function(){
		var $container = $('#container');
		$.jart.search.result.prdList.setList();
		//var searchData = $.dr.search.all.getList(searchOptions);
		
		/*$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200 ){
				
				var prdPage = searchList.prdPage;
				var revwPage = searchList.revwPage;
				var photoPage = searchList.photoPage;
				
				$('#tabArea',$container).html($('#allSearchTabItemTemplate').render({
					prdMngLength : prdPage.count,
					photoLength : photoPage.count,
					revwLength : revwPage.count
				}));
				
				$('.searchAllCont',$container).html($('#allSearchFormTemplate').render({
					total : prdPage.count + photoPage.count + revwPage.count,
					searchValue : searchOptions.searchValue,
					prdMngt : prdPage,
					photo : photoPage,
					revw : revwPage
				}));
				
				$('.searchAllCont',$container).html($('#prdMngListTemplate').render({
					list : prdPage.list
				},jsRenderFnc));
				
				$('#photoReviewList',$container).html($('#photoRevwListTemplate').render({
					list : photoPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc));
				
				$('#reviewList',$container).html($('#generalRevwListTemplate').render({
					list : revwPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc));
				
				var $reviewGrid = $('.reviewList ul').imagesLoaded(function() {
					$reviewGrid.isotope({});
				});			
				
				var criteoViewList = [];//크리테오 viewList 변수
				for(var i = 0; i < prdPage.list.length; i++){
					if(i < 3){
						criteoViewList[i] = prdPage.list[i].prd_mng_seq;	
					}else{
						break; 
					}			
				}
				Criteo 리스팅페이지 트래커
				try{
					window.criteo_q = window.criteo_q || [];
					window.criteo_q.push(
						{ event: "setAccount", account: 30252 },
						{ event: "setHashedEmail", email: cstmMd5HashEmail },
						{ event: "setSiteType", type: "d" },
						{ event: "viewList", item: criteoViewList }
					);
				}catch(e){}

				$.jart.search.result.allList.setList.addEvent();	
			}				
		});*/		
	};
	
	$.jart.search.result.allList.setList.addEvent = function(){
		var $container = $('#container'); 
		
/*		$.jart.search.result.revwList.setList.addEvent();
		$.jart.search.result.photoList.setList.addEvent()*/;
		$.jart.search.result.prdList.setList.addEvent();
		
		/*탭 클릭시 css변경*/
		$(".tabType1 a",$container).on("click", function(){
			var index = $(this).parent().index();
			$(this).parent("li").addClass("on").siblings("li").removeClass("on");
		});
		/*전체 탭 클릭시 all List 호출*/
		$("#all",$container).on("click", function(){
			delete searchOptions.sortOption;
			searchOptions.pageNumber = 1;
			$.jart.search.result.allList.setList();
		});
		/*상품 탭 클릭시 상품 List 호출*/		
		$("#product",$container).on("click", function(){
			searchOptions.pageNumber = 1;
			$.jart.search.result.prdList.setList();
		});
		/*포토리뷰 탭 클릭시 포토리뷰 List 호출*/
		$("#photo",$container).on("click", function(){
			searchOptions.pageNumber = 1;
			$.jart.search.result.photoList.setList();
		});
		/*한줄리뷰 탭 클릭시 한줄리뷰 List 호출*/
		$("#revw",$container).on("click", function(){
			searchOptions.pageNumber = 1;
			$.jart.search.result.revwList.setList();
		});
		
		$("#morePrd",$container).on("click", function(){
			$("#product",$container).trigger('click');
		});
		
		$("#morePhoto",$container).on("click", function(){
			$("#photo",$container).trigger('click');
		});
		
		$("#moreRevw",$container).on("click", function(){
			$("#revw",$container).trigger('click');
		});
		
	};
	
	$.jart.search.result.revwList.setList = function(){
		var $container = $('#container'); 
		var sortOptions = [
			{text : '최신 리뷰순',value : 'wrt_dt'},
			{text : '조회 순',value : 'hit_cnt'}
		];
		
		searchOptions.sortOption = sortOptions[0].value;
		
		var searchData = $.dr.search.revw.getList(searchOptions);
		
		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var revwPage = searchList.revwPage;
							
				$('.searchAllCont',$container).html($('#searchFormTemplate').render({
					saerchTarget : 'revw',
					page : revwPage
				}));
				
				$('#reviewList',$container).html($('#generalRevwListTemplate').render({
					list : revwPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc));
				
				$.jart.search.result.revwList.setList.addEvent(revwPage);	
			}				
		});	
	};
	
	
	$.jart.search.result.revwList.goToPage = function(pageNumber){
		var $container = $('#container'); 
		searchOptions.pageNumber = pageNumber;
		var searchData = $.dr.search.revw.getList(searchOptions);
		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var revwPage = searchList.revwPage;

				var $newItems = $('#generalRevwListTemplate').render({
					list : revwPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc);
				
				$reviewGrid.isotope('insert', $($newItems)); 
				
				$reviewGrid = $reviewGrid.imagesLoaded(function() {
					$reviewGrid.isotope({});
				});

				if(revwPage.pageNumber < revwPage.last){
					
					dataReady = true;
					autoContsAtch();					
				}
			}				
		});	
	};
	
	$.jart.search.result.revwList.setList.addEvent = function(revwPage){
		var $container = $('#container'); 
		$reviewGrid = $('#reviewList',$container).imagesLoaded(function() {
			$reviewGrid.isotope({});
		});
		
		$('input[name=sortOptions]',$container).on('change',function(){
			searchOptions.sortOption = this.value;
			$.jart.search.result.revwList.goToPage(1);
		});
		
		if(revwPage.last > 1){
			dataLoad = function(){
				$.jart.search.result.revwList.goToPage(++searchOptions.pageNumber);
			}
			
			dataReady = true;
			autoContsAtch();			
		}
	};
	
	$.jart.search.result.photoList.setList = function(){
		var $container = $('#container'); 
		var sortOptions = [
			{text : '최신 리뷰순',value : 'wrt_dt'},
			{text : '조회 순',value : 'hit_cnt'}
		];
		
		searchOptions.sortOption = sortOptions[0].value;
		
		var searchData = $.dr.search.photo.getList(searchOptions);
		
		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var photoPage = searchList.photoPage;
							
				$('.searchAllCont',$container).html($('#searchFormTemplate').render({
					saerchTarget : 'photo',
					page : photoPage,
					sortOptions : sortOptions
				}));
				
				$('.reviewList',$container).append('<ul id="photoReviewList"></ul>');
				
				$('#photoReviewList',$container).html($('#photoRevwListTemplate').render({
					list : photoPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc));
				
				$.jart.search.result.photoList.setList.addEvent(photoPage);	
			}				
		});	
	};
	
	$.jart.search.result.photoList.goToPage = function(pageNumber){
		var $container = $('#container'); 
		searchOptions.pageNumber = pageNumber;
		var searchData = $.dr.search.photo.getList(searchOptions);
		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var photoPage = searchList.photoPage;
				
				var $newItems = $('#photoRevwListTemplate').render({
					list : photoPage.list,
					skinTypeCd : $.jart.prd.revw.cds.skinTypeCd,
					skinWoryCd : $.jart.prd.revw.cds.skinWoryCd
				},jsRenderFnc);
				
				$reviewGrid.isotope('insert', $($newItems)); 

				$reviewGrid = $reviewGrid.imagesLoaded(function() {
					$reviewGrid.isotope({});
				});
				
				if(photoPage.pageNumber < photoPage.last){
					
					dataReady = true;
					autoContsAtch();					
				}
			}				
		});	
	};
	
	$.jart.search.result.photoList.setList.addEvent = function(photoPage){
		var $container = $('#container'); 
		$reviewGrid = $('#photoReviewList',$container).imagesLoaded(function() {
			$reviewGrid.isotope({});
		});
		
		$('input[name=sortOptions]',$container).on('change',function(){
			$('.reviewList').html('');
			$('.reviewList',$container).append('<ul id="photoReviewList"></ul>');
			
			$reviewGrid = $('#photoReviewList').imagesLoaded(function() {
				$reviewGrid.isotope({});
			});
			
			searchOptions.sortOption = this.value;
			$.jart.search.result.photoList.goToPage(1);
		});
		
		if(photoPage.last > 1){
			dataLoad = function(){
				$.jart.search.result.photoList.goToPage(++searchOptions.pageNumber);
			}
			
			dataReady = true;
			autoContsAtch();			
		}
		
	};
	
	$.jart.search.result.prdList.setList = function(){
		var $container = $('#container');
		var sortOptions = [
			{text : '판매량 순',value : '001'},
			{text : '신상품 순',value : '002'},
			{text : '리뷰 많은 순',value : '003'},
			{text : '낮은 금액 순',value : '004'},
			{text : '높은 금액 순',value : '005'}
		];
		
		searchOptions.sortOption = sortOptions[0].value;
		
		var searchData = $.dr.search.prd.getList(searchOptions);		

		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var prdPage = searchList.prdPage;
								
				$('.searchAllCont',$container).html($('#searchFormTemplate').render({
					saerchTarget : 'product',
					page : prdPage,
					sortOptions : sortOptions
				}));

				$('#pdtList',$container).html($('#prdMngListTemplate').render({
					list : prdPage.list
				},jsRenderFnc));
				
				// set paging
				// 서버로 부터 받은 전체 갯수와 현재 페이지를 이용 페이징 처리
				var pagingParam = {
					totalCount : parseInt(prdPage.count), // 전체 갯수
					pageNumber : parseInt(prdPage.pageNumber), // 현재 페이지
					listSize : parseInt(prdPage.rows),// 한페이지에 표시할 항목 개수
					//pageSize : parseInt($('#pages').val()), // page bar count 1 2 3 4 5 6 7 8 9 10
					functionName : '$.jart.search.result.prdList.goToPage' // 각 페이지마다 click할 함수 이름
				};
				$.ib.paging.draw($('.paging',$container),pagingParam);
				
				$.jart.search.result.prdList.setList.addEvent();	
				
				/*var criteoViewList = [];//크리테오 viewList 변수
				for(var i = 0; i < prdPage.list.length; i++){
					if(i < 3){
						criteoViewList[i] = prdPage.list[i].prd_mng_seq;	
					}else{
						break; 
					}			
				}
				Criteo 리스팅페이지 트래커
				try{
					window.criteo_q = window.criteo_q || [];
					window.criteo_q.push(
						{ event: "setAccount", account: 30252 },
						{ event: "setHashedEmail", email: cstmMd5HashEmail },
						{ event: "setSiteType", type: "d" },
						{ event: "viewList", item: criteoViewList }
					);
				}catch(e){}*/
			}				
		});	
	};
	
	$.jart.search.result.prdList.goToPage = function(pageNumber){
		var $container = $('#container'); 
		
		searchOptions.pageNumber = pageNumber;
		var searchData = $.dr.search.prd.getList(searchOptions);
		$.when(searchData)
		.done(function(searchList){
			if(searchList.status === 200){
				
				var prdPage = searchList.prdPage;

				$('#pdtList',$container).html($('#prdMngListTemplate').render({
					list : prdPage.list
				},jsRenderFnc));
				
				// set paging
				// 서버로 부터 받은 전체 갯수와 현재 페이지를 이용 페이징 처리
				var pagingParam = {
					totalCount : parseInt(prdPage.count), // 전체 갯수
					pageNumber : parseInt(prdPage.pageNumber), // 현재 페이지
					listSize : parseInt(prdPage.rows),// 한페이지에 표시할 항목 개수
					//pageSize : parseInt($('#pages').val()), // page bar count 1 2 3 4 5 6 7 8 9 10
					functionName : '$.jart.search.result.prdList.goToPage' // 각 페이지마다 click할 함수 이름
				};
				
				var criteoViewList = [];//크리테오 viewList 변수
				for(var i = 0; i < prdPage.list.length; i++){
					if(i < 3){
						criteoViewList[i] = prdPage.list[i].prd_mng_seq;	
					}else{
						break; 
					}			
				}
//				Criteo 리스팅페이지 트래커
				try{
					window.criteo_q = window.criteo_q || [];
					window.criteo_q.push(
						{ event: "setAccount", account: 30252 },
						{ event: "setHashedEmail", email: cstmMd5HashEmail },
						{ event: "setSiteType", type: "d" },
						{ event: "viewList", item: criteoViewList }
					);
				}catch(e){}
				
				$.ib.paging.draw($('.paging',$container),pagingParam);
				$.jart.search.result.prdList.setList.addEvent();	
			}				
		});	
	};
	
	
	$.jart.search.result.prdList.setList.addEvent = function(){
		var $container = $('#container');
		var $prdMngListArea = $('#pdtList',$container);
		
		$('input[name=sortOptions]',$container).on('change',function(){
			$('#reviewList').html('');
			searchOptions.sortOption = this.value;
			$.jart.search.result.prdList.goToPage(1);
		});
		
		$('a[name=btaDtlView]',$prdMngListArea).on('click',$.jart.prd.common.toGoView);
		
		//바로구매
		$('.opt_buying .btn_plus',$prdMngListArea).on('click',$.jart.prd.common.openPurchase);
		
		//장바구니
		$('.opt_buying .cart',$prdMngListArea).on('click',$.jart.prd.common.setCart);

		//위시리스트
		$('.opt_buying .wish',$prdMngListArea).on('click',$.jart.prd.common.setWish);
		
		//입고 알림
		$('.opt_buying .sellAlram',$prdMngListArea).on('click',$.jart.prd.common.openSellAlram);
	};
	
})(jQuery);