$("#barsIcon").live("click", function(){
	
	disableControlBtnNotActive();
	
	$(this).removeClass("bars-icon-standard").addClass("bars-icon-selected");
	
	hideAllPanelsExcept("bars");
	
});	
