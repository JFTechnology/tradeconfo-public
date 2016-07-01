/*
 * JBoss, Home of Professional Open Source
 * Copyright 2013, Red Hat, Inc. and/or its affiliates, and individual
 * contributors by the @authors tag. See the copyright.txt in the
 * distribution for a full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.tools.examples.rest;

import java.util.List;
import java.util.Map.Entry;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.Invocation.Builder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.PathSegment;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;

/**
 * JAX-RS Example
 * <p/>
 * This class produces a RESTful service to read/write the contents of the
 * members table.
 */
@Path("/{resourceName}")
@Produces("application/vnd.api+json")
@RequestScoped
public class ProxyRESTService {

    @Inject
    private Logger log;

    @Inject
    private WebTarget remoteService;

    @Inject
    private Client client;

    @PathParam("resourceName")
    private String resourceName;

    @HeaderParam("Authorization")
    private String auth;

    @Context
    private UriInfo uriInfo;

    private WebTarget target;

    @PostConstruct
    void construct() {

        log.info("construct : " + resourceName);
        log.info("construct : " + auth);

        target = remoteService.path(resourceName);

        UriBuilder builder = UriBuilder.fromPath("https://uat.tradeconfo.com");

        for (PathSegment entry : uriInfo.getPathSegments()) {

            builder = builder.path(entry.getPath());
        }

        for (Entry<String, List<String>> entry : uriInfo.getQueryParameters()
                .entrySet()) {

            builder = builder.queryParam(entry.getKey(),
                    entry.getValue().toArray());
        }

        log.info("construct : " + builder.build());

        target = client.target(builder);
    }

    @GET
    public JsonArray get() {

        log.info("construct : " + resourceName);
        log.info("construct : " + auth);
        log.info("construct : " + remoteService);

        Builder builder = target.request();
        builder.header("Authorization", auth);

        Invocation invocation = builder.buildGet();

        log.info(resourceName);
        log.info(target.getUri().toString());
        log.info(invocation.toString());

        Response response = invocation.invoke();

        log.info(String.valueOf(response.getStatus()));
        log.info(response.getStatusInfo().toString());

        return Json.createArrayBuilder().build();
    }

    /**
     * @param id
     */
    @GET
    @Path("/{id}")
    public Object get(@PathParam("id") String id) {

        log.info("construct : " + resourceName);
        log.info("construct : " + auth);
        log.info("construct : " + remoteService);

        Builder builder = target.request();
        builder.header("Authorization", auth);

        Invocation invocation = builder.buildGet();

        log.info(resourceName);
        log.info(target.getUri().toString());
        log.info(invocation.toString());

        Response response = invocation.invoke();

        log.info(String.valueOf(response.getStatus()));
        log.info(response.getStatusInfo().toString());

        if (response.hasEntity()) {

            JsonObject entity = response.readEntity(JsonObject.class);
            response.close();

            return Response.status(response.getStatusInfo()).entity(entity)
                    .build();
        }

        return Response.status(response.getStatusInfo()).build();
    }
}
