/*
 * Copyright (C) 2020. Mikhail Kulesh
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

import 'dart:ui';

import "package:shared_preferences/shared_preferences.dart";

import "../constants/Strings.dart";
import "../iscp/StateManager.dart";
import "../utils/Convert.dart";
import "../utils/Logging.dart";
import "../utils/Pair.dart";
import "CfgModule.dart";
import "CheckableItem.dart";

// Tabs
enum AppTabs
{
    LISTEN,
    MEDIA,
    SHORTCUTS,
    DEVICE,
    RC,
    RI,
}

class CfgAppSettings extends CfgModule
{
    // Theme
    static const Pair<String, String> THEME = Pair<String, String>("theme", Strings.pref_theme_default);
    String _theme;

    String get theme
    => _theme;

    set theme(String value)
    {
        _theme = value;
        saveStringParameter(THEME, value);
    }

    // System language
    static const Locale DEFAULT_LOCALE = Locale("en", "US");
    Locale _systemLocale;

    set systemLocale(Locale value)
    {
        _systemLocale = value;
        Logging.info(this, "system locale: " + _systemLocale.toString());
    }

    // Language
    static const Pair<String, String> LANGUAGE = Pair<String, String>("language", Strings.pref_language_default);
    String _language;

    String get language
    {
        if (_language == "system")
        {
            return _systemLocale != null && Strings.app_languages.contains(_systemLocale.languageCode) ?
            _systemLocale.languageCode : DEFAULT_LOCALE.languageCode;
        }
        return _language;
    }

    set language(String value)
    {
        _language = value;
        saveStringParameter(LANGUAGE, value);
    }

    // Text size
    static const Pair<String, String> TEXT_SIZE = Pair<String, String>("text_size", Strings.pref_text_size_default);
    String _textSize;

    String get textSize
    => _textSize;

    set textSize(String value)
    {
        _textSize = value;
        saveStringParameter(TEXT_SIZE, value);
    }

    // The latest opened tab
    static const Pair<String, int> OPENED_TAB = Pair<String, int>("opened_tab", 0);
    int _openedTab;

    int get openedTab
    => _openedTab;

    set openedTab(int value)
    {
        _openedTab = value;
        saveIntegerParameter(OPENED_TAB, value);
    }

    // Visible tabs
    static final String VISIBLE_TABS = "visible_tabs";

    // Remote interface
    static const Pair<String, bool> RI_AMP = Pair<String, bool>("remote_interface_amp", true);
    bool _riAmp;

    bool get riAmp
    => _riAmp;

    static const Pair<String, bool> RI_CD = Pair<String, bool>("remote_interface_cd", true);
    bool _riCd;

    bool get riCd
    => _riCd;

    // methods
    CfgAppSettings(final SharedPreferences preferences) : super(preferences);

    @override
    void read()
    {
        _theme = getString(THEME, doLog: true);
        _language = getString(LANGUAGE, doLog: true);
        _textSize = getString(TEXT_SIZE, doLog: true);
        _openedTab = getInt(OPENED_TAB, doLog: true);
        _riAmp = getBool(RI_AMP, doLog: true);
        _riCd = getBool(RI_CD, doLog: true);
    }

    @override
    void setReceiverInformation(StateManager stateManager)
    {
        // empty
    }

    static String getTabName(AppTabs item)
    {
        return item.index < Strings.pref_visible_tabs_names.length ? Strings.pref_visible_tabs_names[item.index].toUpperCase() : "";
    }

    List<AppTabs> getVisibleTabs()
    {
        final List<AppTabs> result = List();
        final List<String> defItems = List();
        AppTabs.values.forEach((i) => defItems.add(Convert.enumToString(i)));
        for (CheckableItem sp in CheckableItem.readFromPreference(this, VISIBLE_TABS, defItems))
        {
            for (AppTabs i in AppTabs.values)
            {
                if (sp.checked && Convert.enumToString(i) == sp.code)
                {
                    result.add(i);
                }
            }
        }
        return result;
    }
}