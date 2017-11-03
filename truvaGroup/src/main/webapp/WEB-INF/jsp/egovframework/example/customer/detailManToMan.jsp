<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<section class="section">
         <div class="container">
            <div class="row">
                 <div class="col-md-7">
                 <div class="content">
                         <div class="blog-wrapper">
                             <div class="blog-item">
								<div class="row">
				                 	 <div class="shortcode-wrap">
				                 	 <h1 class="customtitle">1:1 문의</h1>
				                 	 <hr class="custom1">
				                     <form class="contact-form search-top">
				                     <c:forEach items="${mantoManDetail}" var="adminFAQDetail" varStatus="status">
										  <thead>
											<tr>
												<th>번호</th>
												<td class="ip-text" colspan="2"><input class="ip-text" type="text" name="boardNumber" id="boardNumber" value=""><c:out value="${mantoManDetail.boardNumber}"/>
											</tr>
		
				 
				                         <div class="col-md-12">
				                             <div class="form-group">
				                             <input type="text" class="form-control" name="boardTitle" id="boardTitle"><c:out value="${mantoManDetail.boardTitle}"/>
				                             </div>
				                         </div>
				
				                         <div class="col-md-12">
				                             <div class="form-group">
				                             <input type="text" class="form-control" name="boardFaqClass" placeholder="boardFaqClass"><c:out value="${mantoManDetail.boardFaqClass}"/>
				                             </div>
				                         </div>
				
				                          </thead>
										</c:forEach>
				                         <div class="col-md-12">
				                             <textarea placeholder="Your message" class="form-control"></textarea>
				                             <button class="btn btn-primary" type="submit">Submit</button>
				                         </div>
				                     </form>
				                     </div>
				                </div>
				           	 </div>
				      	</div>
                 </div>
			</div>
         </div><!-- end container -->
</section><!-- end section -->

	