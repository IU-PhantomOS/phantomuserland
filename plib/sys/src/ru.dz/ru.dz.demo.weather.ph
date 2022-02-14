/**
 *
 * Phantom OS - Phantom language library
 *
 * Copyright (C) 2005-2019 Dmitry Zavalishin, dz@dz.ru
 *
 * Simple weater widget
 *
 *
**/

package .ru.dz.demo;

import .phantom.os;
import .internal.io.tty;
import .internal.window;
import .internal.bitmap;
import .internal.tcp;
import .internal.connection;
import .internal.directory;
import .internal.long;

attribute const * ->!;

class weather
{

    var win : .internal.window;
    var sleep : .internal.connection;
    var http : .internal.tcp;

    var stepNo : int;

    void run(var console : .internal.io.tty)
    {
        var bmp : .internal.bitmap;
        var json_string : .internal.string;
        var json : .internal.directory;

        stepNo = 0;

        // Loading background image

        bmp = new .internal.bitmap();
        bmp.loadFromString(getBackgroundImage());
        
        // Initializing the window

        win = new .internal.window();
        win.setWinPosition(200,100);
        win.setTitle("Weather");

        win.clear();

		win.drawImage( 0, 0, bmp );
        drawInfoBar();

        win.update();

        // Initializing timer connection

		sleep = new .internal.connection();
        sleep.connect("tmr:");

        // Initializing TCP socket

        http = new .internal.tcp ();

        // Main loop

        while(1)
        {
            // Requesting data

			console.putws("Weather win: curl\n");
            
            json_string = http.curl( "http://192.168.31.231:80/weather", "" );

			console.putws(json_string);
			console.putws(json_string);       
			console.putws("Weather win: curl = ");
			console.putws("\n");

            // Outputing data
          
            win.clear();
            win.drawImage( 0, 0, bmp );

            win.setFg(0xFF93CDB4); // light green
		    win.setBg(0xFFccccb4); // light milk

            drawInfoFromData(json, "p1");
            drawInfoFromData(json, "p2");
            drawInfoFromData(json, "p3");
            drawInfoBar();

            win.update();

            // Incrementing step number

            stepNo = stepNo + 1;

            // Blocking for some time

			console.putws("Weather win: sleep\n");

            sleep.block(null, 5);

			console.putws("Weather win: out of sleep\n");
		}

    }

    void drawInfoBar() {
        win.drawString(0, 0, "Update #");
        win.drawString(70, 0, stepNo.toString());
    }

    void drawInfoFromData(var json : .internal.directory, var id: .internal.string) {

        var point : .internal.directory;
        var p_x : .internal.long;
        var p_y : .internal.long;
        var p_val : .internal.long;
        var p_dir : .internal.string;

        point = json.get(id);
        p_x = point.get("x");
        p_y = point.get("y");
        p_dir = point.get("dir");
        p_val = point.get("val");

        win.drawString( castLongToInt(p_x), castLongToInt(p_y), p_val.toString() );
        win.drawString( castLongToInt(p_x), castLongToInt(p_y) + 15, p_dir );
    }

    int castLongToInt(var val_long : .internal.long)
    {
        var tmp_str : .internal.string;
        var val_int : int;

        tmp_str = val_long.toString();

        val_int = tmp_str.toInt();

        return val_int;
    }

    .internal.string getBackgroundImage()
    {
        return import "../resources/demo2/inno_map.ppm" ;
        //return import "../resources/backgrounds/snow_weather.ppm" ;
    }
	
};

