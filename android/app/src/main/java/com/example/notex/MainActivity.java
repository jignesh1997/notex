package com.example.notex;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.RequiresApi;

import java.security.MessageDigest;
import java.util.Base64;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
  //  printHashKey(this);
    GeneratedPluginRegistrant.registerWith(this);
  }

 /* public static void printHashKey(Context context) {
    try {
      final PackageInfo info = context.getPackageManager().getPackageInfo(context.getPackageName(), PackageManager.GET_SIGNATURES);
      for (android.content.pm.Signature signature : info.signatures) {
        final MessageDigest md = MessageDigest.getInstance("SHA");
        md.update(signature.toByteArray());
        final String hashKey = new String(Base64.getEncoder().encode(md.digest()  ));
        Log.i("AppLog", "key:" + hashKey + "=");
      }
    } catch (Exception e) {
      Log.e("AppLog", "error:", e);
    }
  }*/
}
