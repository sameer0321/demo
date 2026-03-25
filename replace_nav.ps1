$dir = "c:\Users\lokes\OneDrive\Desktop\demo"
$files = Get-ChildItem -Path $dir -Filter "*.html" | Select-Object -ExpandProperty FullName

$newNav = @"
<li class="menu-item-has-children"><a href="#">Programs</a>
                        <ul class="sub-menu">
                            <li class="menu-item-has-children"><a href="#">Distance</a>
                                <ul class="sub-menu">
                                    <li><a href="program-diploma.html">Diploma</a></li>
                                    <li><a href="program-distance.html#undergraduate-level">UG</a></li>
                                    <li><a href="program-distance.html#postgraduate-level">PG</a></li>
                                    <li><a href="program-pg-diploma.html">PG Diploma</a></li>
                                    <li><a href="program-online.html">Online</a></li>
                                </ul>
                            </li>
                            <li><a href="program-regular.html">Regular</a></li>
                            <li class="menu-item-has-children"><a href="#">ODL</a>
                                <ul class="sub-menu">
                                    <li><a href="program-distance.html#undergraduate-level">UG</a></li>
                                    <li><a href="program-distance.html#postgraduate-level">PG</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
"@

foreach ($file in $files) {
    $content = Get-Content -Path $file -Raw
    $pattern = '(?si)<li class="menu-item-has-children">\s*<a href="#">Programs</a>.*?</ul>\s*</li>(?=\s*<li>\s*<a href="contact\.html">Contact Us</a>\s*</li>)'
    
    $newContent = [regex]::Replace($content, $pattern, $newNav)
    Set-Content -Path $file -Value $newContent -Encoding utf8
}
