package com.example.fragmentactivitydemo;

import android.support.v4.app.FragmentManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
      static final String TAG_CHILD_FRAGMENT = "child_fragment";
      static final String TAG_INNER_FRAGMENT = "inner_fragment";

    private ChildFragment mChildFragment;
    private InnerFragment mInnerFragment;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FragmentManager fm = getSupportFragmentManager();
       // mChildFragment=new ChildFragment();

        //fm.beginTransaction().replace(R.id.fragment_contaner,mChildFragment,TAG_CHILD_FRAGMENT).commit();
        mChildFragment = (ChildFragment) fm.findFragmentByTag(TAG_CHILD_FRAGMENT);
        if(mChildFragment==null){
            mChildFragment=new ChildFragment();
            fm.beginTransaction().add(R.id.fragment_contaner,mChildFragment,TAG_CHILD_FRAGMENT).commit();
            mInnerFragment=new InnerFragment();
            fm.beginTransaction().add(R.id.fragment_contaner,mInnerFragment,TAG_INNER_FRAGMENT).commit();
        }

    }
}
