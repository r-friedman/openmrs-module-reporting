<%@ include file="/WEB-INF/template/include.jsp"%>
<openmrs:require privilege="Manage Reports" otherwise="/login.htm" redirect="/module/reporting/index.htm" />
<%@ include file="../localHeader.jsp"%>

<script type="text/javascript" charset="utf-8">
var $j = jQuery.noConflict();
$j(document).ready(function() {

	// ======  Tabs: Cohort Definition Tabs  ================================================

	$j('#cohort-definition-tabs').tabs();
	$j('#cohort-definition-tabs').show();

	// ======  DataTable: Cohort Definition Parameter  ======================================
	
	$j('#cohort-definition-parameter-table').dataTable( {
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"bSort": false,
		"bInfo": false,
		"bAutoWidth": false
	} );			

	$j('#cancel-button').click(function(event){
		// To prevent the submit
		event.preventDefault();

		// Redirect to the listing page
		window.location.href='<c:url value="/module/reporting/manageReportSchemas.list"/>';
	});
	
} );

</script>

<style>
	form ul { margin:0; padding:0; list-style-type:none; width:100%; }
	form li { display:block; margin:0; padding:6px 5px 9px 9px; clear:both; color:#444; }
	label.desc { line-height:150%; margin:0; padding:0 0 3px 0; border:none; color:#222; display:block; font-weight:bold; }
</style>

<div id="page">

<div id="container">

	<h1>Cohort Definition Editor</h1>

		<div id="cohort-definition-tabs" class="ui-tabs-hide">			
			<ul>
                <li><a href="#cohort-definition-basic-tab"><span>Basic</span></a></li>
            </ul>
		</div>		
	
		<div id="cohort-definition-basic-tab">
			<form method="post" action="saveCohortDefinition.form">
			
				<ul>				
					<li>
						<label class="desc" for="id">ID</label>				
						<div>
							<input type="hidden" name="uuid" value="${cohortDefinition.uuid}" />
							<c:choose>
								<c:when test="${!empty cohortDefinition.uuid}">${cohortDefinition.uuid}</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${!empty cohortDefinition.id}">${cohortDefinition.id}</c:when>
										<c:otherwise>(new)</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>	
						</div>
					</li>				
					<li>
						<label class="desc" for="type">Type</label>			
						<div>
							${cohortDefinition.class.name}
							<input type="hidden" name="type" value="${cohortDefinition.class.name}" tabindex="1" />
						</div>
					</li>
					
					<li>
						<label class="desc" for="name">Name</label>			
						<div>
							<input type="text" 
									class="field text medium" 
									id="name" 
									name="name"
									value="${cohortDefinition.name}"
									size="50" 
									tabindex="2"/>
						</div>
					</li>
					<li>
						<label class="desc" for="description">Description</label>			
						<div>
							<textarea id="description" 
									class="field text short" cols="80" tabindex="3"
									name="description">${cohortDefinition.description}</textarea>			
						</div>
					</li>

					<li>
						<label class="desc" for="parameter">Adding Parameters</label>			
						
						<div>
							<table id="cohort-definition-parameter-table" class="display">
								<thead>
									<tr>
										<th width="1%" align="left">Add?</th>
										<th align="left">Name</th>
										<th align="left">Default Value</th>
										<th width="1%" align="left">User Input?</th>
										<th width="1%" align="left">Req'd?</th>
									</tr>	
								</thead>
								<tbody>
									<c:forEach items="${cohortDefinition.availableParameters}" var="parameter" varStatus="varStatus">
										<tr>
											<td>
												<input type="checkbox" name="parameter.${parameter.name}.include"/>
											</td>
											<td>
												${parameter.name}
											</td>
											<td>
												<openmrs:fieldGen type="${parameter.clazz}" formFieldName="parameter.${parameter.name}.defaultValue" val="${parameter.defaultValue}" parameters="" />
											</td>
											<td>
												<input type="checkbox" name="parameter.${parameter.name}.allowUserInput" />
											</td>
											<td>
												<c:choose>
													<c:when test="${p.required}">
														<input type="hidden" name="parameter.${parameter.name}.required" value="true" />[x]
													</c:when>
													<c:otherwise>
														<input type="checkbox" name="parameter.${parameter.name}.required"/></td>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
								</tfoot>								
							</table>
						</div>
					</li>
						
					<li>					
						<div align="center">				
							<input id="saveForm" class="btTxt submit" type="submit" value="Save" tabindex="7" />
							<input id="saveForm" class="btTxt submit" type="submit" value="Cancel" tabindex="8"/>				
						</div>					
					</li>
				</ul>				
			</form>
		</div>
	</div>	
</div>