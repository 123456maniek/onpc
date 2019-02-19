/*
 * Copyright (C) 2018. Mikhail Kulesh
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

package com.mkulesh.onpc.iscp.messages;

import android.support.annotation.NonNull;
import android.support.annotation.StringRes;

import com.mkulesh.onpc.R;
import com.mkulesh.onpc.iscp.EISCPMessage;
import com.mkulesh.onpc.iscp.ISCPMessage;

/*
 * Firmware Update message
 */
public class FirmwareUpdateMsg extends ISCPMessage
{
    public final static String CODE = "UPD";

    public enum Status implements StringParameterIf
    {
        NONE("N/A", R.string.device_firmware_none),
        ACTUAL("00", R.string.device_firmware_actual),
        NEW_VERSION("01", R.string.device_firmware_new_version),
        UPDATE_COMPLETE("CMP", R.string.device_firmware_update_complete),
        NET("NET", R.string.device_firmware_net);

        final String code;
        final int descriptionId;

        Status(final String code, final int descriptionId)
        {
            this.code = code;
            this.descriptionId = descriptionId;
        }

        public String getCode()
        {
            return code;
        }

        @StringRes
        public int getDescriptionId()
        {
            return descriptionId;
        }
    }

    private final Status status;

    FirmwareUpdateMsg(EISCPMessage raw) throws Exception
    {
        super(raw);
        status = (Status) searchParameter(data, Status.values(), Status.NONE);
    }

    public FirmwareUpdateMsg(Status status)
    {
        super(0, null);
        this.status = status;
    }

    public Status getStatus()
    {
        return status;
    }

    @NonNull
    @Override
    public String toString()
    {
        return CODE + "[" + data + "; STATUS=" + status.getCode() + "]";
    }

    @Override
    public EISCPMessage getCmdMsg()
    {
        return new EISCPMessage('1', CODE, status.getCode());
    }

    @Override
    public boolean hasImpactOnMediaList()
    {
        return false;
    }
}
