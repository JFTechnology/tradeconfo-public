<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:api="http://tradeconfo.com/ns/api"
	xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsi api"
>

	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />

	<xsl:variable name="TYPES"
		select="document('../docs/types.xml')/api:types/api:type" />

	<xsl:variable name="ENUMS"
		select="document('../docs/enums.xml')/api:enums/api:enum" />

	<xsl:param name="api.version" select="'1.1.7'" />
	<xsl:param name="api.date" select="'2016-Jun-19'" />

	<xsl:template match="/api:api">

		<html>
			<head>
				<link rel="stylesheet"
					href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
					integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
					crossorigin="anonymous"
				></link>
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
					integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
					crossorigin="anonymous"
				></script>
				<link
					href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
					rel="stylesheet" integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1"
					crossorigin="anonymous"
				></link>
			</head>
			<body>
				<div class="container-fluid" style="margin:2em;">
					<div class="row"
						style="background-color:#eee; margin:2em; padding:2em; border-top:solid #bbb 2pt;"
					>
						<div class="col-md-12">
							<h1 id="top">Tradeconfo.com FX Services - public API documentation</h1>
							<div style="width:40em;padding:1em;" class="text-justify">

								<h4>
									Version :
									<xsl:value-of select="$api.version" />
								</h4>
								<h4>
									Created :
									<xsl:value-of select="$api.date" />
								</h4>

								<h2>Introduction</h2>
								<p>Tradeconfo.com FX API defines a set of REST based services that support
									FX brokerages and their agents and customers.</p>
								<p>This document specifies the REST based access to a compliant
									Tradeconfo.com FX service. This includes ...</p>
								<ul>
									<li>Customer accounts, beneficiaries and profiles</li>
									<li>Trade and payment reports</li>
									<li>Beneficiary creation</li>
									<li>Quote requests and acceptance</li>
								</ul>
								<p>
									The Tradeconfo.com FX API implements the
									<a href="http://jsonapi.org/">JSON API</a>
									format for all REST resources. The JSON API format provides a well
									defined
									layout for modeling resources and the REST services that support
									them.
								</p>

								<h2>Applications</h2>
								<p>The Tradeconfo.com FX APIs currently supports two applications ...</p>
								<ul>
									<xsl:for-each select="api:application">
										<li>
											<a href="#{generate-id()}">
												<xsl:value-of select="@name" />
											</a>
										</li>
									</xsl:for-each>
								</ul>

								<h2>Notes</h2>
								<ul>
									<xsl:for-each select="api:note">
										<li>
											<a href="#{generate-id()}">
												<xsl:value-of
													select="document(concat('../docs/notes/', @src))/api:note/@title" />
											</a>
										</li>
									</xsl:for-each>
								</ul>
							</div>
						</div>
					</div>
					<xsl:apply-templates select="api:application" />
					<xsl:apply-templates select="api:note" />
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="api:api/api:application">

		<div id="{generate-id()}" class="row"
			style="background-color:#eee; margin:2em; padding:2em; border-top:solid #bbb 2pt;"
		>
			<div class="col-xs-12">
				<h1>
					API application :
					<xsl:value-of select="@name" />
				</h1>
				<p>
					<xsl:copy-of select="api:description" />
				</p>

				<table class="table table-sm table-striped">
					<thead>
						<tr>
							<th>Resource</th>
							<th>REST endpoints</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="api:resource">
							<xsl:variable name="resource"
								select="document(concat('../docs/resources/', @name,'.xml'))/api:resource" />
							<xsl:variable name="resourceId" select="concat(../@name, '-', @name)" />
							<tr>
								<td class="text-nowrap">
									<a href="#{$resourceId}">
										<strong>
											<xsl:value-of select="$resource/@type" />
										</strong>
									</a>
								</td>
								<td class="text-nowrap">
									<xsl:if test="$resource/api:url">
										<table>
											<tbody>
												<xsl:for-each select="$resource/api:url">
													<tr>
														<td style="min-width:5em;">
															<a href="#{$resourceId}">
																<span class="label label-info">
																	<xsl:value-of select="@method" />
																</span>
															</a>
														</td>
														<td>
															<a href="#{$resourceId}">
																<xsl:value-of select="@url" />
																<xsl:if test="api:parameter">
																	<i class="text-warning">
																		<xsl:text>?</xsl:text>
																		<xsl:for-each select="api:parameter">
																			<xsl:if test="position() > 1">
																				<xsl:text>&amp;</xsl:text>
																			</xsl:if>
																			<xsl:value-of select="concat(@key, '=', @value)" />
																		</xsl:for-each>
																	</i>
																</xsl:if>
															</a>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</xsl:if>
								</td>
								<td>
									<xsl:copy-of select="$resource/api:description" />
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</div>
		</div>

		<xsl:apply-templates select="api:resource" />

	</xsl:template>

	<xsl:template match="api:api/api:application/api:resource">

		<xsl:variable name="resource"
			select="document(concat('../docs/resources/', @name,'.xml'))/api:resource" />

		<xsl:variable name="applicationId" select="../@name" />
		<xsl:variable name="resourceId" select="concat(../@name, '-', @name)" />

		<div id="{$resourceId}" class="row"
			style="background-color:#eee; margin:2em; padding:2em; border-top:solid #bbb 2pt;"
		>
			<div class="col-md-12">

				<div class="row">
					<div class="col-md-12" style="border-bottom:dotted #bbb 1pt; margin-bottom:1em;">
						<h3>
							Resource :
							<xsl:value-of select="../@name" />
							/
							<xsl:value-of select="$resource/@type" />
							<a
								href="mailto:support@plutusfx.com?subject=API documentation : {../@name}/{@name}"
								style="float:right;font-size:smaller;" title="Report issue or request support"
							>
								<i class="fa fa-fw fa-envelope-o"></i>
							</a>
							<a href="#top" style="float:right;font-size:smaller;" title="Back to top">
								<i class="fa fa-fw fa-arrow-circle-up" aria-hidden="true"></i>
							</a>
						</h3>
					</div>
				</div>

				<div class="row">
					<div class="col-md-6">
						<h3>Structure</h3>
						<div class="panel panel-info">
							<div class="panel-heading">
								<h3 class="panel-title">
									<xsl:text>Content of a '</xsl:text>
									<strong>
										<xsl:value-of select="$resource/@type" />
									</strong>
									<xsl:text>' resource</xsl:text>
								</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped table-hover" style="font-size:smaller;">
									<tbody>
										<tr>
											<th>Resource</th>
											<th>Type</th>
											<th>Required</th>
											<th>Comment</th>
										</tr>
										<tr>
											<td>id</td>
											<td>
												string
											</td>
											<td>
												<i class="fa fa-fw fa-check-circle text-info"></i>
											</td>
											<td>
												System id - should not be interpreted
											</td>
										</tr>
										<tr>
											<td>type</td>
											<td>
												string
											</td>
											<td>
												<i class="fa fa-fw fa-check-circle text-info"></i>
											</td>
											<td>
												<xsl:value-of select="$resource/@type" />
											</td>
										</tr>
									</tbody>
									<xsl:if test="$resource/api:attribute">
										<tbody>
											<tr>
												<th>Attributes</th>
												<th>Type</th>
												<th>Required</th>
												<th>Comment</th>
											</tr>
										</tbody>
										<tbody>
											<xsl:apply-templates select="$resource/api:attribute" />
										</tbody>
									</xsl:if>
									<xsl:if test="$resource/api:relationship">
										<tbody>
											<tr>
												<th>Relationships</th>
												<th>Resource</th>
												<th>Required</th>
												<th>Comment</th>
											</tr>
										</tbody>
										<tbody>
											<xsl:apply-templates select="$resource/api:relationship">
												<xsl:with-param name="applicationId" select="$applicationId"></xsl:with-param>
											</xsl:apply-templates>
										</tbody>
									</xsl:if>
								</table>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<h3>Description</h3>
						<div class="well">

							<xsl:for-each select="$resource/api:description">
								<p>
									<xsl:copy-of select="." />
								</p>
							</xsl:for-each>
							<xsl:for-each select="$resource/api:comment">
								<p>
									<xsl:copy-of select="current()" />
								</p>
							</xsl:for-each>
						</div>
						<h3>Rest Endpoints</h3>
						<xsl:apply-templates select="$resource/api:url" />

						<xsl:if test="$resource/api:url/api:example">

							<div class="panel panel-info">
								<div class="panel-heading">
									<h4>Examples</h4>
								</div>
								<div class="panel-body">

									<div>
										<ul class="nav nav-tabs" role="tablist">
											<xsl:for-each select="$resource/api:url/api:example">

												<xsl:variable name="document"
													select="document(concat('../docs/examples/', @file))" />

												<xsl:variable name="exampleId" select="generate-id()" />

												<li role="presentation">
													<a href="#{$resourceId}-{$exampleId}" aria-controls="{$resourceId}-{$exampleId}"
														role="tab" data-toggle="tab"
													>
														<xsl:value-of select="position()" />
														:
														<xsl:value-of select="$document/api:example/@title" />
													</a>
												</li>
											</xsl:for-each>
											<li role="presentation" class="active">
												<a href="#{$resourceId}-hide" aria-controls="{$resourceId}-hide"
													role="tab" data-toggle="tab"
												>Hide</a>
											</li>
										</ul>
										<div class="tab-content">
											<xsl:for-each select="$resource/api:url/api:example">

												<xsl:variable name="exampleId" select="generate-id()" />
												<xsl:apply-templates select=".">
													<xsl:with-param name="contentId"
														select="concat($resourceId, '-', $exampleId)" />
												</xsl:apply-templates>
											</xsl:for-each>
											<div role="tabpanel" class="tab-pane active text-muted" id="{$resourceId}-hide">
											</div>
										</div>
									</div>
								</div>
							</div>

						</xsl:if>
					</div>
				</div>
			</div>
		</div>

	</xsl:template>

	<xsl:template match="api:api/api:note">

		<xsl:variable name="note"
			select="document(concat('../docs/notes/', @src))/api:note" />

		<div class="row"
			style="background-color:#eee; margin:2em; padding:2em; border-top:solid #bbb 2pt;"
		>
			<div class="col-md-6">
				<h3 id="{generate-id()}">
					<xsl:value-of select="$note/@title" />
					<a href="#top" style="float:right;font-size:smaller;">Back to top</a>
				</h3>
				<xsl:copy-of select="$note/*" copy-namespaces="no"
					exclude-result-prefixes="api" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="api:attribute[@type = 'enum']">
		<xsl:variable name="enum-name" select="@enum" />
		<xsl:variable name="enum" select="$ENUMS[@name=$enum-name]" />
		<tr>
			<td style="white-space: nowrap;">
				<xsl:value-of select="@name" />
			</td>
			<td>
				enum
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@required = true()">
						<i class="fa fa-fw fa-check-circle text-info"></i>
					</xsl:when>
					<xsl:otherwise>
						<i class="fa fa-fw fa-times-circle text-danger"></i>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:apply-templates select="api:comment" />
				<xsl:apply-templates select="$enum" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="api:attribute[@type != 'enum']">
		<xsl:variable name="type-name" select="@type" />
		<xsl:variable name="type" select="$TYPES[@name=$type-name]" />
		<tr>
			<td style="white-space: nowrap;">
				<xsl:value-of select="@name" />
			</td>
			<td class="text-nowrap">
				<xsl:value-of select="@type" />
				<xsl:if test="@many">
					(many)
				</xsl:if>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@required = true()">
						<i class="fa fa-fw fa-check-circle text-info"></i>
					</xsl:when>
					<xsl:otherwise>
						<i class="fa fa-fw fa-times-circle text-danger"></i>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:apply-templates select="api:comment" />
				<xsl:if test="$type">
					<p>
						<xsl:copy-of select="$type/api:comment" />
					</p>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="api:comment">
		<p>
			<xsl:copy-of select="." />
		</p>
	</xsl:template>

	<xsl:template match="api:enum">
		<p>
			<xsl:value-of select="@description" />
		</p>
		<table class=" table-condensed" style="font-size:smaller;">
			<caption>
				<strong>Valid enum values</strong>
			</caption>
			<tbody>
				<xsl:apply-templates />
			</tbody>
		</table>
	</xsl:template>

	<xsl:template match="api:enum/api:value">
		<tr>
			<td>
				<strong>
					<xsl:value-of select="@value" />
				</strong>
			</td>
			<td>
				<xsl:value-of select="@description" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="api:relationship">
		<xsl:param name="applicationId" />
		<tr>
			<td style="white-space: nowrap;">
				<xsl:value-of select="@name" />
			</td>
			<td style="white-space: nowrap;">
				<a href="#{concat($applicationId, '-', @resource)}">
					<xsl:value-of select="@resource" />
				</a>
				<xsl:if test="@many = 'true'">
					(many)
				</xsl:if>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@required = true()">
						<i class="fa fa-fw fa-check-circle text-info"></i>
					</xsl:when>
					<xsl:otherwise>
						<i class="fa fa-fw fa-times-circle text-danger"></i>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:value-of select="." />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="api:url">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h4 class="pull-left ">
					<span class="label label-info">
						<xsl:value-of select="@method" />
					</span>
				</h4>
				<p class="h4" style="padding-left:4em;">
					<strong>
						<xsl:text>/&lt;path-to-app&gt;/</xsl:text>
						<xsl:value-of select="@url" />
					</strong>
					<xsl:if test="api:parameter">
						<i class="text-warning">
							<xsl:text>?</xsl:text>
							<xsl:for-each select="api:parameter">
								<xsl:if test="position() > 1">
									<xsl:text>&amp;</xsl:text>
								</xsl:if>
								<xsl:value-of select="concat(@key, '=', @value)" />
							</xsl:for-each>
						</i>
					</xsl:if>
				</p>
			</div>

			<div class="panel-body">
				<xsl:for-each select="api:comment">
					<p>
						<xsl:copy-of select="." />
					</p>
				</xsl:for-each>
			</div>

			<xsl:if test="api:parameter">
				<div class="panel-body">
					<table class="table table-sm table-striped">
						<thead>
							<tr>
								<th>Query parameter</th>
								<th>Value</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="api:parameter">
								<tr>
									<td>
										<xsl:value-of select="@key" />
									</td>
									<td>
										<xsl:value-of select="@value" />
									</td>
									<td>
										<xsl:value-of select="@comment" />
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
			</xsl:if>
		</div>

	</xsl:template>

	<xsl:template match="api:url/api:example">

		<xsl:param name="contentId" />

		<xsl:variable name="document" select="document(concat('../docs/examples/', @file))" />

		<div role="tabpanel" class="tab-pane" id="{$contentId}">

			<h3>
				Example :
				<xsl:value-of select="$document/api:example/@title" />
			</h3>
			<span style="display:block;">
				<xsl:value-of select="$document/api:example/@method" />
				<xsl:value-of select="$document/api:example/@url" />
				<xsl:text> HTTP/1.1</xsl:text>
			</span>
			<span style="display:block;">Accept: application/vnd.api+json</span>
			<span style="display:block;">Authorization: Bearer eyJhbGciOiJSUzI1N...</span>
			<xsl:if test="$document/api:example/api:request">
				<div style="color:green;margin-top:1em;">
					<span style="display:block;">Request body...</span>
					<pre>
						<xsl:copy-of select="$document/api:example/api:request" />
					</pre>
				</div>
			</xsl:if>
			<xsl:if test="$document/api:example/api:response">
				<div style="color:blue;margin-top:1em;">
					<span style="display:block;">Response body...</span>
					<pre>
						<xsl:copy-of select="$document/api:example/api:response" />
					</pre>
				</div>
			</xsl:if>
		</div>
	</xsl:template>

</xsl:stylesheet>