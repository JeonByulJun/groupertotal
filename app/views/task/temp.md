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