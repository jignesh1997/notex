package com.example.fragmentactivitydemo;


import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


/**
 * A simple {@link Fragment} subclass.
 */
public class InnerFragment extends Fragment {
    AlertDialog alertDiaog;

    public InnerFragment() {

    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_inner, container, false);
    }

    @Override
    public void onStart() {
        super.onStart();
        alertDiaog=new AlertDialog.Builder(
                getActivity()).setTitle("Title").setMessage("Hello World").setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                Fragment fragment = getActivity().getSupportFragmentManager().findFragmentByTag(MainActivity.TAG_INNER_FRAGMENT);
                if(fragment!=null){
                    getActivity().getSupportFragmentManager().beginTransaction().remove(fragment).commit();
                }

            }
        }).show();
    }

    @Override
    public void onStop() {
        super.onStop();
        alertDiaog.dismiss();
    }
}
