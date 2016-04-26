<style>
		abc, tr, td{
			border-bottom: 2px solid #707070;
		}
		abc, th {
    	height: 30px;
		}
		abc{
			 margin=10px;
		}

		@keyframes slidein {
		  from {
		    background-color: white;
		  }
		
		  to {
		    background-color: #606060;
		  }
		}
	</style>
	<table class="abc">
		<colgroup> <col>
		<colgroup> <col> <col> <col>
		<thead>
	 	<tr> <th>
	 		<% base = 9 %>
		<%for i in 0..base %>
		  <% a = Date.today + i %>
		 	<th style="border-right: 1px solid #707070; border-left: 1px solid #707070;"> <%=a.strftime("%m/%d") %>
		<% end %>
		<tbody>
			<% @tasklist.each_with_index do |t,i| %>
				<% if t.duedate == nil %>
				<% t.duedate = Date.today %>
				<% end %>
			  <tr> <th scope=rowgroup style="border: 1px solid #707070;"> <%=t.taskname%> </th>
			  <% for j in 0..base %>
			  	<% a = t.duedate - (Date.today + j) %>
				  <% if a >= 0 %>
				  	<td id="<%=i*10+j%>th" style="border-right: 1px dotted #707070; background-color: #606060; animation-duration: 3s; animation-name: slidein;"></td>
				  	
				  <% else %>
				  	<td style="border-right: 1px dotted #707070;"></td>
				  <% end %>
			  <% end %>
			<% end %>
		</tbody>
	</table>
	
	<% @tasklist.each_with_index do |taskdo,slideridx| %>
			<% if taskdo.wansungdo < 100 %>
  			  	<div class="row">
					<div class="col-md-3">
				    	<%sender = User.find(taskdo.sender)%>
					    <aside>
					    	<img class="img-rounded" alt="profile" src="<%=sender.image%>" width="40px" height="40px" style="float: left; margin-right: 8px;">
						    <h5> <%=sender.first_name%> <br>
						    	<%=sender.email%></h5>
				    	</aside>
				    </div>
				    <div class="col-md-1">
					    <h5><%=taskdo.taskname%></h5>
			 		</div>
					<div class="col-md-1">
					    <h5><%=taskdo.duedate%></h5>
					</div>
					<div class="col-md-4">
						<div class="bar">
						  	<div class="bar-inner bar-<%=(taskdo.wansungdo).to_i %>" data-percent="<%=(taskdo.wansungdo).to_i %>%"></div>
						</div>
						<script> horild(); </script>
					</div>
					<div class="col-md-2">
						<a class="btn btn-primary" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						   Revise Completion
						</a>
						<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						  Button with data-target
						</button>
						<div class="collapse" id="collapseExample">
							<div class="well">
								
							</div>
						</div>
					    
				    </div>
					<div class="col-md-3">
						<% @commentdo = Comment.where(:task_id => taskdo.id) %>
						<% @commentdo.each do |commentdo| %>
							<li><%=commentdo.wansungdo_log%>% : <%=commentdo.comment_log%></li>
						<% end %>
					</div>
				</div>
			<% end %>
		<% end %>