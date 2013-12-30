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
  var haveReferenceTime    = false;
  var haveTZOffset         = false;
  var drift                = 0;
  var referenceTime        = 0;
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

  function updateDriftFromMetadata(t)
  {
    var es;
    var i;
    var j;

    if (!haveDrift)
    {
      es = document.getElementsByTagName('meta');

      for (i = 0; i < es.length; i++)
      {
        if (es[i].getAttribute('name') == 'reference-time:now:unix')
        {
          haveDrift = true;
          drift = t - es[i].getAttribute('content');
        }
        else if ((es[i].getAttribute('name') == 'reference-time:unix'))
        {
          if (!haveReferenceTime)
          {
            haveReferenceTime = true;
            referenceTime = es[i].getAttribute('content');
          }

          if (!haveDrift)
          {
            haveDrift = true;
            drift = t - es[i].getAttribute('content');
          }
        }
      }
      if (haveDrift)
      {
        updateClockDrift();
        t = unixTime();
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

  function updateTimer(t)
  {
    var es = document.getElementById('difference');
    var secondsToday;
    var n;
    var days;
    var hours;
    var minutes;
    var seconds;
    var str;
    var difference = referenceTime - t;

    t = difference * (difference < 0 ? -1 : 1);

    if (es == null)
    {
      return;
    }
    else
    {
      days = Math.floor(t / clockOptionsSDays);
      secondsToday = t % clockOptionsSDays;

      hours = Math.floor(secondsToday % clockOptionsSDays / clockOptionsSMinutes);
      minutes = Math.floor(secondsToday % clockOptionsSMinutes / clockOptionsSSeconds);
      seconds = Math.floor(secondsToday % clockOptionsSSeconds);

      str = 'Unix time ' + referenceTime;
      if (t == 0)
      {
        str += ' is the current time stamp.';
      }
      else
      {
        str += ' refers to a point in the ' + (difference < 0 ? 'past' : 'future');
        if (days != 0)
        {
          str += ', ' + days + ' days';
        }
        if (hours != 0)
        {
          str += ', ' + hours + ' hours';
        }
        if (minutes != 0)
        {
          str += ', ' + minutes + ' minutes';
        }
        if (seconds != 0)
        {
          str += ', ' + seconds + ' seconds';
        }
        str += ' ' + (difference < 0 ? 'ago' : 'from now') + '.';
      }

      n = document.createTextNode(str);

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
    if (!haveDrift)
    {
      t = updateUnixTime(t);
      t = updateClockOptions(t);
      t = updateDriftFromMetadata(t);
    }
    else
    {
      updateUnixTime(t);
      updateClockOptions(t);
    }

    updateTimeZone();
    updateClock(t);
    updateDigitalClock(t);
    updateTimer(t);

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
