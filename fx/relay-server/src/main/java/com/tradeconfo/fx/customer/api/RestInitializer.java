/*
 * Copyright (c) 1999-2016 by JF Technology (UK) Ltd. All Rights Reserved.
 *
 * This software is the proprietary information of JF Technology (UK) Ltd.
 * Use is subject to license terms.
 *
 * Created on 1 Jul 2016 by stephen.flynn@jftechnology.com.
 */
package com.tradeconfo.fx.customer.api;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

/**
 * RestInitializer - provides mount point for REST endpoints.
 *
 * @author stephen.flynn@jftechnology.com
 * @since 1.0
 */
@ApplicationPath("/relay")
public class RestInitializer extends Application {

    public RestInitializer() {

        super();
    }
}
