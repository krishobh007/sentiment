/**
* Directive used to get the ngrepeat end event
* will be helpful for larger data sets
*/
sntRover.directive('ngrepeatend', function(){
	return function(scope, element, attrs) {
		//we are using ngrepeat $last in cracking this
	    if (scope.$last){
	      scope.$emit("NG_REPEAT_COMPLETED_RENDERING");
	    }
  };
});