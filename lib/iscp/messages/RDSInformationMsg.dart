/*
 * Enhanced Controller for Onkyo and Pioneer Pro
 * Copyright (C) 2019-2021 by Mikhail Kulesh
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details. You should have received a copy of the GNU General
 * Public License along with this program.
 */

import "../EISCPMessage.dart";
import "../ISCPMessage.dart";

/*
 * RDS Information Command (RDS Model Only)
 */
class RDSInformationMsg extends ISCPMessage
{
    static const String CODE = "RDS";
    static const String TOGGLE = "UP";

    RDSInformationMsg(EISCPMessage raw) : super(CODE, raw);

    RDSInformationMsg.output(String v) : super.output(CODE, v);

    @override
    bool hasImpactOnMediaList()
    {
        return false;
    }
}