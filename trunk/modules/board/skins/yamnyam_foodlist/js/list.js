// <![CDATA[

//토글 스위치 변수
var toggleCalory = true;
var togglePrice = true;

var data = new Array();
var sumPrice = new Object();
var minimumPrice = new Object();
var payment = new Object();

$(document).ready(
	function()
	{
		$('#dock').Fisheye(
			{
				maxWidth: 9,
				items: 'a',
				itemsText: 'span',
				container: '.dock-container',
				itemWidth: 43,
				proximity: 90,
				halign : 'center'
			}
		)
	}
);


/*수량 변경을 위한 함수*/
function amount(num, i){
	if($('#numBox_'+num).val() == 1 && i == 1) {
		$('#numBox_'+num).val(parseInt($('#numBox_'+num).val())+i);
	} else if($('#numBox_'+num).val() > 1 && $('#numBox_'+num).val() < 9) {
		$('#numBox_'+num).val(parseInt($('#numBox_'+num).val())+i);	
	} else if($('#numBox_'+num).val() >= 9 && i == -1) {
		$('#numBox_'+num).val(parseInt($('#numBox_'+num).val())+i);
	}
}	


/*가격대 검색을 위한 slider UI*/


$(document).ready(function() {

//	var search_min = '{$search_min}';
//	var search_max = '{$search_max}';	

	if(	search_min != '' ) {
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 30000,
			step: 1000,
			values: [ search_min, search_max ],
			slide: function( event, ui ) {
				$( "#sliderPrice1" ).empty();
				$( "#sliderPrice1" ).append(ui.values[ 0 ]);
				$( "#sliderPrice2" ).empty();
				$( "#sliderPrice2" ).append(ui.values[ 1 ]);
				$(".search_min").attr({value:ui.values[ 0 ]});
				$(".search_max").attr({value:ui.values[ 1 ]});
			}
		});
	
		$( "#sliderPrice1" ).empty();
		$( "#sliderPrice1" ).append(search_min);
		$( "#sliderPrice2" ).empty();
		$( "#sliderPrice2" ).append(search_max);
		$(".search_min").attr({value:search_min});
		$(".search_max").attr({value:search_max});
	} else {
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 30000,
			step: 1000,
			values: [ 0, 30000 ],
			slide: function( event, ui ) {
				$( "#sliderPrice1" ).empty();
				$( "#sliderPrice1" ).append(ui.values[ 0 ]);
				$( "#sliderPrice2" ).empty();
				$( "#sliderPrice2" ).append(ui.values[ 1 ]);
				
				$(".search_min").attr({value:ui.values[ 0 ]});
				$(".search_max").attr({value:ui.values[ 1 ]});
			}
		});
	
		$( "#sliderPrice1" ).empty();
		$( "#sliderPrice1" ).append($( "#slider-range" ).slider( "values", 0 ));
		$( "#sliderPrice2" ).empty();
		$( "#sliderPrice2" ).append($( "#slider-range" ).slider( "values", 1 ));		
		$(".search_min").attr({value:$( "#slider-range" ).slider( "values", 0 )});
		$(".search_max").attr({value:$( "#slider-range" ).slider( "values", 1 )});
	}
});
// ]]>

function selectCategory(category){
	$(".food_category").attr({value:category});
}