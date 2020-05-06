/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.bidi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class BiDiTestActivity extends Activity {

    private static final String KEY_CLASS = "class";
    private static final String KEY_TITLE = "title";
    private static final String KEY_FRAGMENT_ID = "id";
    
    private ListView mList;
    
    private AdapterView.OnItemClickListener mOnClickListener = 
            new AdapterView.OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent, View v, int position, long id) {
                    onListItemClick((ListView)parent, v, position, id);
                }
    };

    private void onListItemClick(ListView lv, View v, int position, long id) {
        // Show the test
        Map<String, Object> map = (Map<String, Object>)lv.getItemAtPosition(position);
        int fragmentId = (Integer) map.get(KEY_FRAGMENT_ID);
        Fragment fragment = getFragmentManager().findFragmentById(fragmentId);
        if (fragment == null) {
            try {
                // Create an instance of the test
                Class<? extends Fragment> clazz = (Class<? extends Fragment>) map.get(KEY_CLASS);  
                fragment = clazz.newInstance();
                
                // Replace the old test f