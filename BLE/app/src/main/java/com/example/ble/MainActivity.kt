package com.example.ble

import android.support.v7.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    companion object {
        var fragment = BlankFragment()
        var fragment2 = BlankFragment2()
        var current = 1
    }

    var fragmentstr = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        /*if(savedInstanceState!=null){
           when{
               savedInstanceState.getString("fragment").contentEquals("1")->{
                   fragment.arguments!!.putBundle("savedInstanceState",savedInstanceState)
                   supportFragmentManager.beginTransaction().replace(R.id.framelayoutContaner,  fragment).commit()

               }
               savedInstanceState.getString("fragment").contentEquals("2")->{
                   fragment2.arguments!!.putBundle("savedInstanceState",savedInstanceState)
                   supportFragmentManager.beginTransaction().replace(R.id.framelayoutContaner, fragment2).commit()
               }
           }

        }*/
        when (current) {
            1 -> {
                supportFragmentManager.beginTransaction().replace(R.id.framelayoutContaner, fragment).commit()
            }
            2 -> {
                supportFragmentManager.beginTransaction().replace(R.id.framelayoutContaner, fragment2).commit()
            }
        }
    }

    override fun onSaveInstanceState(savedInstanceState: Bundle) {
        super.onSaveInstanceState(savedInstanceState)
        if (!savedInstanceState.containsKey("fragment")) {
            savedInstanceState.putString("fragment", "1")
        }
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
        fragmentstr = savedInstanceState.getString("fragment")
    }
}
