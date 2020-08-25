(function($) {

	// Global
	$.ib = $.ib || {};

	// Paging
	$.ib.paging = {};

	$.ib.paging.attribute = {
		first : {
			css : 'first',
			title : '맨 처음'
		},
		prev : {
			css : 'prev',
			title : '이전 5페이지'
		},
		next : {
			css : 'next',
			title : '다음 5페이지'
		},
		last : {
			css : 'last',
			title : '맨 마지막'
		}
	};
	$.ib.paging.img = function(type, language) {
		if (type == 'first') {
			return '<img src="https://image.drjart.com/front/' + ((!language || language == '') ? 'ko' : language) + '/images/common/arr_pageFirst.png" alt="First"/>';
		} else if (type == 'prev') {
			return '<img src="https://image.drjart.com/front/' + ((!language || language == '') ? 'ko' : language) + '/images/common/arr_pagePrev.png" alt="Previous"/>';
		} else if (type == 'next') {
			return '<img src="https://image.drjart.com/front/' + ((!language || language == '') ? 'ko' : language) + '/images/common/arr_pageNext.png" alt="Next">';
		}
		return '<img src="https://image.drjart.com/front/' + ((!language || language == '') ? 'ko' : language) + '/images/common/arr_pageLast.png" alt="Last">';
	};

	$.ib.paging.defaults = {
		totalCount : 0, // all count
		pageNumber : 0, // current page number
		listSize : 10, // list row size
		pageSize : 10, // page row size
		language : 'ko',
		functionName : 'goToPage'
	};

	$.ib.paging.draw = function(targetObj, options) {
		var opt = $.extend({}, $.ib.paging.defaults, options);
		var action = {
			init : function() {
				var totalPage = Math.ceil(opt.totalCount / opt.listSize);
				var totalPageList = Math.ceil(totalPage / opt.pageSize);
				var pageList = Math.ceil(opt.pageNumber / opt.pageSize);

				if (pageList < 1) {
					pageList = 1;
				}
				if (pageList > totalPageList) {
					pageList = totalPageList;
				}
				var startPageList = (pageList - 1) * opt.pageSize + 1;
				var endPageList = startPageList + opt.pageSize - 1;

				if (startPageList < 1) {
					startPageList = 1;
				}
				if (endPageList > totalPage) {
					endPageList = totalPage;
				}
				if (endPageList < 1) {
					endPageList = 1;
				}

				var innerHTML = action.getPageItemLink(1, (opt.pageNumber > 1), $.ib.paging.attribute.first, $.ib.paging.img(
						'first', opt.language));
				innerHTML += action.getPageItemLink((startPageList - 1), (startPageList > 1), $.ib.paging.attribute.prev,
						$.ib.paging.img('prev', opt.language));
				for (var i = startPageList; i <= endPageList; i++) {

					innerHTML += action.getNumberLink(i, (opt.pageNumber != i));
					if (i < endPageList) {
						// innerHTML += ' | '; // separate action
					}
				}
				innerHTML += action.getPageItemLink((endPageList + 1), (endPageList < totalPage), $.ib.paging.attribute.next,
						$.ib.paging.img('next', opt.language));
				innerHTML += action.getPageItemLink(totalPage, (opt.pageNumber < totalPage), $.ib.paging.attribute.last,
						$.ib.paging.img('last', opt.language));
				$(targetObj).html(innerHTML);
			},

			getNumberLink : function(pageNumber, drawLink) {

				if (drawLink) {
					return '<a href="javascript:' + opt.functionName + '(' + pageNumber + ')">'
							+ action.displayPageNumber(pageNumber) + '</a>\n';
				} else {
					return '<span class="current">' + action.displayPageNumber(pageNumber) + '</span>\n';
				}
			},

			getPageItemLink : function(pageNumber, drawLink, attribute, imageHtml) {
				if (drawLink) {
					return '<span class="' + attribute.css + '"><a href="javascript:' + opt.functionName + '(' + pageNumber
							+ ');" title="' + attribute.title + '">' + imageHtml + '</a></span> \n';
				} else {
					return '<span class="' + attribute.css + '"><a href="javascript:void(0);" title="' + attribute.title + '">' + imageHtml + '</a></span> \n';
				}
			},
			displayPageNumber : function(pageNumber) {
				return parseInt(pageNumber);
			}

		};
		action.init();
	}

})(jQuery);