import html

with open('c:\\Users\\lokes\\OneDrive\\Desktop\\demo\\raw_courses_data.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

output = []
for line in lines:
    line = line.strip()
    if not line: continue
    parts = line.split('\t')
    if len(parts) == 1:
        # Category row
        output.append(f'              <tr class="cat-row">\n                <td colspan="5">{html.escape(parts[0])}</td>\n              </tr>')
    else:
        # Data row
        # format: sno, course, specialization, eligibility, duration
        sno = parts[0]
        course = parts[1] if len(parts) > 1 else ''
        spec = parts[2] if len(parts) > 2 else ''
        elig = parts[3] if len(parts) > 3 else ''
        dur = parts[4] if len(parts) > 4 else ''
        
        row_html = f'''              <tr>
                <td class="sno">{html.escape(sno)}</td>
                <td>{html.escape(course)}</td>
                <td>{html.escape(spec)}</td>
                <td>{html.escape(elig)}</td>
                <td>{html.escape(dur)}</td>
              </tr>'''
        output.append(row_html)

tbody_code = '\n'.join(output)

table_code = f'''            <thead>
              <tr>
                <th class="sno">#</th>
                <th>Course</th>
                <th>Specialization</th>
                <th>Eligibility</th>
                <th>Duration</th>
              </tr>
            </thead>
            <tbody>
{tbody_code}
            </tbody>'''

with open('c:\\Users\\lokes\\OneDrive\\Desktop\\demo\\table_output.txt', 'w', encoding='utf-8') as f:
    f.write(table_code)

print("success")
