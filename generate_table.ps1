$data = Get-Content -Path "c:\Users\lokes\OneDrive\Desktop\demo\raw_courses_data.txt" -Encoding UTF8
$html = @()

foreach ($line in $data) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line -split "`t"
    if ($parts.Count -eq 1) {
        $cat = $parts[0].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;")
        $html += "              <tr class=`"cat-row`">"
        $html += "                <td colspan=`"5`">$cat</td>"
        $html += "              </tr>"
    } else {
        $sno = $parts[0].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;")
        $course = if ($parts.Count -gt 1) { $parts[1].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;") } else { "" }
        $spec = if ($parts.Count -gt 2) { $parts[2].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;") } else { "" }
        $elig = if ($parts.Count -gt 3) { $parts[3].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;") } else { "" }
        $duration = if ($parts.Count -gt 4) { $parts[4].Replace("&", "&amp;").Replace("<","&lt;").Replace(">","&gt;") } else { "" }

        $html += "              <tr>"
        $html += "                <td class=`"sno`">$sno</td>"
        $html += "                <td>$course</td>"
        $html += "                <td>$spec</td>"
        $html += "                <td>$elig</td>"
        $html += "                <td>$duration</td>"
        $html += "              </tr>"
    }
}

$tbody = $html -join "`n"

$tableCode = @"
            <thead>
              <tr>
                <th class="sno">#</th>
                <th>Course</th>
                <th>Specialization</th>
                <th>Eligibility</th>
                <th>Duration</th>
              </tr>
            </thead>
            <tbody>
$tbody
            </tbody>
"@

$file = "c:\Users\lokes\OneDrive\Desktop\demo\program-regular.html"
$content = Get-Content -Path $file -Raw -Encoding UTF8
# Replace from <thead> to </tbody>
$pattern = '(?si)<thead>.*?</tbody>'
$newContent = [regex]::Replace($content, $pattern, $tableCode)
Set-Content -Path $file -Value $newContent -Encoding UTF8
