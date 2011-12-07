<?php

$u = explode ('/', $_SERVER['REQUEST_URI']);
$x = explode (',', $u[2]);

$o = '<?xml version="1.0" encoding="UTF-8" ?>'.
     '<page xmlns="http://syn.chroni.se/2011">'.
     '<'.$x[0];

switch ($x[0])
{
	case 'clock':
		if (!empty($x[1])) $o.= ' render="'.htmlspecialchars($x[1]).'"';
		break;
	default:
                header("Status: 404 Not Found");
		exit();
}

$o.= '/>';

$o.= '</page>';

$d = str_replace('/php/generate-page.php','',$_SERVER['SCRIPT_FILENAME']);

if (!is_dir ($d))
{
	mkdir ($d);
}

$uri = '/'.$u[1].'/'.$u[2];

$f = $d.'/'.$u[2].'.cache.xml';

file_put_contents ($f, $o);

header ('Location: '.$uri);

