<?php

$m = array();

error_reporting (E_ALL | E_STRICT);

if (preg_match ('%^/((x?html|svg)(\+js)?/)?([\w\s@,.:+\'-]+)$%', $_SERVER['REQUEST_URI'], $m) > 0)
{
        define('type', $m[1]);
        define('code', $m[4]);

        $u = explode ('/', $_SERVER['REQUEST_URI']);
        $x = explode (',', code);

        $o = '<?xml version="1.0" encoding="UTF-8" ?>';

        if (preg_match ('%^unix:([\d-]+)(:([\w\s@,.:+\'-]+))?$%', code, $m))
        {
                define ('timestamp', $m[1]);
                define ('label', $m[3]);

                $o .= '<page xmlns="http://syn.chroni.se/2011" name="Unix Time: '.timestamp.'">';

                $o .= '<time unix="'.timestamp.'" />';

                if (label != '')
                {
                    $o .= '<label>'.label.'</label>';
                }

                $o .= '<clock render="difference" />';
                $o .= '<information type="clock-drift" />';
                $o .= '<time calendar="gregorian" clock="digital" />';
        }
        else
        {
                $o .= '<page xmlns="http://syn.chroni.se/2011">';

                switch ($x[0])
                {
                        case 'clock':
                                if (!empty($x[1])) $o.= '<clock render="'.htmlspecialchars($x[1]).'" />';
                                break;
                        default:
                                header("Status: 404 Not Found");
                                exit();
                }
        }

        $o.= '</page>';

        $d = str_replace('/php/generate-page.php','',$_SERVER['SCRIPT_FILENAME']);

        if (!is_dir ($d))
        {
                mkdir ($d);
        }

        $f = $d.'/'.code.'.cache.xml';

        file_put_contents ($f, $o);

        header ('Location: '.$_SERVER['REQUEST_URI']);
}
else
{
        header("Status: 400 Bad Request");
}
