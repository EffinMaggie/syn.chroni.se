var fallback = null;

function keepTime()
{
  window.onload = function(){};
  document.removeEventListener("DOMContentLoaded", keepTime, false);
  if (fallback != null)
  {
    window.clearTimeout(fallback);
  }

  var haveDrift            = false;
  var drift                = 0;
  var haveTZOffset         = false;
  var TZOffset             = 0;
  var clockOptionsSSeconds = 60;
  var clockOptionsSMinutes = 3600;
  var clockOptionsSHours   = 43200;
  var clockOptionsSDays    = 86400;
  var timeout              = null;

  function updateAddressBar()
  {
    if (history.pushState)
      history.pushState({},'current time (clock drift: ' + drift + 's)',
                        location.href.replace(/html\+js\/(.*)/,'html+js/now:'+drift));
  }

  function updateClockDrift()
  {
//    updateAddressBar();

    var es = document.getElementById('clock-drift');
    var i;
    var j;
    var n = document.createTextNode(drift+'s');

    if (es == null)
    {
      return;
    }
    else
    {
      for (j = 0; j < es.childNodes.length; j++)
      {
        if (j == 0)
        {
          es.replaceChild(n,es.childNodes[j]);
        }
        else
        {
          es.removeChild(es.childNodes[j]);
          j--;
        }
      }
    }
  }

  function unixTime()
  {
    if (haveDrift)
    {
      return (new Date().getTime() / 1000) - drift;
    }
    else
    {
      return new Date().getTime() / 1000;
    }
  }

  function updateTimeZone()
  {
    if (!haveTZOffset)
    {
      TZOffset = new Date().getTimezoneOffset() * -1;

      var es = document.getElementById('time-zone');
      var j;
      var n;

      if (es == null)
      {
        return;
      }
      else
      {
        haveTZOffset = true;

        if (TZOffset == 0)
	{
          n = document.createTextNode('GMT');
	}
	else if (TZOffset > 0)
	{
          n = document.createTextNode('GMT+'+(TZOffset/60)+'h');
	}
	else
	{
          n = document.createTextNode('GMT'+(TZOffset/60)+'h');
	}

        for (j = 0; j < es.childNodes.length; j++)
        {
          if (j == 0)
          {
            es.replaceChild(n,es.childNodes[j]);
          }
          else
          {
            es.removeChild(es.childNodes[j]);
            j--;
          }
        }
      }
    }
  }

  function updateUnixTime(t)
  {
    var es = document.getElementById('unix-time');
    var i;
    var j;
    var n = document.createTextNode(Math.floor(t));

    if (es == null)
    {
      return t;
    }
    else
    {
      for (j = 0; j < es.childNodes.length; j++)
      {
        if (j == 0)
        {
          if (!haveDrift)
	  {
	    haveDrift = true;
	    drift = t - es.childNodes[j].textContent;
	    updateClockDrift();
	    t = unixTime();
	    n = document.createTextNode(Math.floor(t));
          }

          es.replaceChild(n,es.childNodes[j]);
        }
        else
        {
          es.removeChild(es.childNodes[j]);
	  j--;
        }
      }
    }

    return t;
  }

  function updateClockOptions(t)
  {
    var es;
    var i;
    var j;

    if (!haveDrift)
    {
      es = document.getElementsByTagName('clock-options');

      for (i = 0; i < es.length; i++)
      {
        haveDrift = true;
        drift = t - es[i].getAttribute('reftime');
        updateClockDrift();
        t = unixTime();
        clockOptionsSSeconds = es[i].getAttribute('sSeconds');
        clockOptionsSMinutes = es[i].getAttribute('sMinutes');
        clockOptionsSHours = es[i].getAttribute('sHours');
        clockOptionsSDays = es[i].getAttribute('sDays');
      }
    }

    return t;
  }

  function updateClock(t)
  {
    var es = document.getElementById('rSeconds');
    var secondsToday = t % clockOptionsSDays;

    if (es != null)
    {
      es.setAttribute('transform', 'rotate('+(secondsToday*360/clockOptionsSSeconds)+',500,500)');
    }

    es = document.getElementById('rMinutes');

    if (es != null)
    {
      es.setAttribute('transform', 'rotate('+(secondsToday*360/clockOptionsSMinutes)+',500,500)');
    }

    es = document.getElementById('rHours');

    if (es != null)
    {
      es.setAttribute('transform', 'rotate('+(secondsToday*360/clockOptionsSHours)+',500,500)');
    }
  }

  function updateDigitalClock(t)
  {
    var es = document.getElementById('clock-digital');
    var secondsToday;
    var n;
    var hours;
    var minutes;
    var seconds;

    if (es == null)
    {
      return;
    }
    else
    {
      secondsToday = t % clockOptionsSDays;

      hours = Math.floor(secondsToday % clockOptionsSDays / clockOptionsSMinutes);
      minutes = Math.floor(secondsToday % clockOptionsSMinutes / clockOptionsSSeconds);
      seconds = Math.floor(secondsToday % clockOptionsSSeconds);

      if (hours < 10) hours = '0' + hours;
      if (minutes < 10) minutes = '0' + minutes;
      if (seconds < 10) seconds = '0' + seconds;

      n = document.createTextNode(hours + ':' + minutes + ':' + seconds);

      for (j = 0; j < es.childNodes.length; j++)
      {
        if (j == 0)
        {
          es.replaceChild(n,es.childNodes[j]);
        }
        else
        {
          es.removeChild(es.childNodes[j]);
	  j--;
        }
      }
    }
  }

  function updateDateTime()
  {
    var t = unixTime();
    t = updateUnixTime(t);
    t = updateClockOptions(t);
    updateTimeZone();
    updateClock(t);
    updateDigitalClock(t);

    t = 1000 - (t * 1000 % 1000);
    if (t < 400)
    {
      t = 1000;
    }

    if (timeout != null)
    {
      window.clearTimeout(timeout);
    }

    timeout = window.setTimeout(updateDateTime, t);
  }

  updateDateTime();
};

document.addEventListener("DOMContentLoaded", keepTime, false);
window.onload = keepTime;
fallback = window.setTimeout(keepTime, 5000); /* this is in case none of the other callbacks made it; this is hopefully never used */
