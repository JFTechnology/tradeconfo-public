/*
 * Copyright (c) 1999-2016 by JF Technology (UK) Ltd. All Rights Reserved.
 *
 * This software is the proprietary information of JF Technology (UK) Ltd.
 * Use is subject to license terms.
 *
 * Created on 1 Jul 2016 by stephen.flynn@jftechnology.com.
 */
package com.tradeconfo.fx.customer.api;

import java.net.URI;
import java.util.List;
import java.util.Map.Entry;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.annotation.PostConstruct;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.json.JsonObject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.Invocation.Builder;
import javax.ws.rs.client.ResponseProcessingException;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.PathSegment;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;

/**
 * RestRelayFXCustomerAPI - provides back to back relay of Rest calls to a
 * tradeconfo.com compliant fx-customer-api service.
 *
 * @author stephen.flynn@jftechnology.com
 * @since 1.0
 */
@Path("/fx-customer-api/{resourceName}")
@Produces(RestRelayFXCustomerAPI.MEDIA_TYPE)
@RequestScoped
public class RestRelayFXCustomerAPI {

    public static final String MEDIA_TYPE = "application/vnd.api+json";

    private static final String HOST = "https://uat.tradeconfo.com";

    @Inject
    private Logger logger;

    @Inject
    private Client client;

    @PathParam("resourceName")
    private String resourceName;

    @HeaderParam("Authorization")
    private String authorization;

    @Context
    private UriInfo uriInfo;

    private Builder builder;

    @PostConstruct
    private void createBuilder() {

        UriBuilder uriBuilder = UriBuilder.fromPath(HOST);

        // copy request path
        for (PathSegment entry : uriInfo.getPathSegments()) {

            uriBuilder = uriBuilder.path(entry.getPath());
        }

        // copy request parameters
        for (Entry<String, List<String>> entry : uriInfo.getQueryParameters()
                .entrySet()) {

            uriBuilder = uriBuilder.queryParam(entry.getKey(),
                    entry.getValue().toArray());
        }

        URI uri = uriBuilder.build();

        WebTarget target = client.target(uri);

        builder = target.request(MEDIA_TYPE);

        // copy request auth token from request
        builder.header("Authorization", authorization);
    }

    /**
     * Relay collection method.
     */
    @POST
    @Consumes(MEDIA_TYPE)
    public Response post(JsonObject post) {

        return buildRelayResponse("POST", post);
    }

    /**
     * Relay collection method.
     */
    @GET
    public Response get() {

        return buildRelayResponse("GET", null);
    }

    /**
     * Relay resource method.
     * 
     * @param id
     */
    @GET
    @Path("/{id}")
    public Response get(@PathParam("id") String id) {

        return buildRelayResponse("GET", null);
    }

    /**
     * Relay resource method.
     * 
     * @param id
     * @param relationship
     */
    @GET
    @Path("/{id}/{relationship}")
    public Response get(@PathParam("id") String id,
            @PathParam("relationship") String relationship) {

        return buildRelayResponse("GET", null);
    }

    private Response buildRelayResponse(String method, JsonObject post) {

        logger.info("building response for URI : " + uriInfo.getAbsolutePath());

        Entity<JsonObject> entity = null;

        if (post != null) {

            entity = Entity.entity(post, MEDIA_TYPE);
        }

        Invocation invocation = builder.build(method, entity);

        try {

            String response = invocation.invoke(String.class);

            return Response.ok(response).build();

        } catch (WebApplicationException e) {

            logger.log(Level.WARNING, e.getMessage(), e);

            return Response.fromResponse(e.getResponse()).build();

        } catch (ResponseProcessingException e) {

            logger.log(Level.WARNING, e.getMessage(), e);

            return Response.serverError().build();
        }
    }
}
