/*
 * Copyright (c) 1999-2016 by JF Technology (UK) Ltd. All Rights Reserved.
 *
 * This software is the proprietary information of JF Technology (UK) Ltd.
 * Use is subject to license terms.
 *
 * Created on 1 Jul 2016 by stephen.flynn@jftechnology.com.
 */
package com.tradeconfo.fx.customer.api;

import java.util.logging.Logger;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;

/**
 * ProducerWebTarget - provides...
 *
 * @author stephen.flynn@jftechnology.com
 * @since 1.0
 */
@Dependent
public class Producers {

    private static ClientBuilder clientBuilder = ClientBuilder.newBuilder();

    @Produces
    public Logger produceLog(InjectionPoint injectionPoint) {

        return Logger.getLogger(
                injectionPoint.getMember().getDeclaringClass().getName());
    }

    @Produces
    public Client produceClient() {

        return clientBuilder.build();
    }
}
