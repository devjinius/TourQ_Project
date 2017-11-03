<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"  prefix="tiles"%>
<!doctype html>
	<head>
		<tiles:insertAttribute name="admin-header"/>
	</head>

	<body>

		<!-- Main content starts -->
		<div class="content">
		
			<tiles:insertAttribute name="admin-left"/>
			
			<tiles:insertAttribute name="admin-content"/>

			<div class="clearfix"></div>
		</div><!--/ Content ends -->
		    
		<script>
	    	if ($('[data-toggle="datepicker"]').length != 0) {
				
				/* Date picker */
				$('[data-toggle="datepicker"]').datepicker({
					autoHide: true,
					language: 'ko-KR',
					format: 'yyyy/ mm/ dd',
					range : true,
			        dayNames: ['일','월','화','수','목','금','토'],
			        dayNamesShort: ['일','월','화','수','목','금','토'],
			        dayNamesMin: ['일','월','화','수','목','금','토']
				});
	    	};
		</script>
	</body>
</html>