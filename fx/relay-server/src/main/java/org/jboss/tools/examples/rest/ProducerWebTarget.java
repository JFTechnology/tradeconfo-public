/*
 * Copyright (c) 1999-2016 by JF Technology (UK) Ltd. All Rights Reserved.
 *
 * This software is the proprietary information of JF Technology (UK) Ltd.
 * Use is subject to license terms.
 *
 * Created on 18 Jun 2016 by stephen.flynn@jftechnology.com.
 */
package org.jboss.tools.examples.rest;

import java.net.URI;
import java.net.URISyntaxException;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.UriBuilder;

/**
 * ProducerWebTarget - provides...
 *
 * @author stephen.flynn@jftechnology.com
 * @since TODO
 */
@Dependent
public class ProducerWebTarget {

    @Produces
    static WebTarget produces() throws URISyntaxException {

        UriBuilder builder = UriBuilder
                .fromUri(new URI("https://uat.tradeconfo.com/fx-customer-api"));

        ClientBuilder clientBuilder = ClientBuilder.newBuilder();

        clientBuilder.hostnameVerifier(new HostnameVerifier() {

            @Override
            public boolean verify(String hostname, SSLSession session) {

                System.out.println(
                        "ProducerWebTarget.produces().new HostnameVerifier() {...}.verify() "
                                + hostname);
                return true;
            }
        });

        return clientBuilder.build().target(builder);
    }

    @Produces
    static Client producesClient() {

        ClientBuilder clientBuilder = ClientBuilder.newBuilder();

        clientBuilder.hostnameVerifier(new HostnameVerifier() {

            @Override
            public boolean verify(String hostname, SSLSession session) {

                System.out.println(
                        "ProducerWebTarget.produces().new HostnameVerifier() {...}.verify() "
                                + hostname);
                return true;
            }
        });

        return clientBuilder.build();
    }
}
