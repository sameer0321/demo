const fs = require('fs');

const data = fs.readFileSync('c:\\Users\\lokes\\OneDrive\\Desktop\\demo\\raw_courses_data.txt', 'utf-8');
const lines = data.split(/\r?\n/);
let output = [];

function escapeHtml(unsafe) {
    if (!unsafe) return '';
    return unsafe
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
}

for (let line of lines) {
    line = line.trim();
    if (!line) continue;
    
    let parts = line.split('\t');
    if (parts.length === 1) {
        output.push(`              <tr class="cat-row">\n                <td colspan="5">${escapeHtml(parts[0])}</td>\n              </tr>`);
    } else {
        let sno = parts[0] || '';
        let course = parts[1] || '';
        let spec = parts[2] || '';
        let elig = parts[3] || '';
        let dur = parts[4] || '';
        
        let rowHtml = `              <tr>
                <td class="sno">${escapeHtml(sno)}</td>
                <td>${escapeHtml(course)}</td>
                <td>${escapeHtml(spec)}</td>
                <td>${escapeHtml(elig)}</td>
                <td>${escapeHtml(dur)}</td>
              </tr>`;
        output.push(rowHtml);
    }
}

let tbodyCode = output.join('\n');

let tableCode = `            <thead>
              <tr>
                <th class="sno">#</th>
                <th>Course</th>
                <th>Specialization</th>
                <th>Eligibility</th>
                <th>Duration</th>
              </tr>
            </thead>
            <tbody>
${tbodyCode}
            </tbody>`;

fs.writeFileSync('c:\\Users\\lokes\\OneDrive\\Desktop\\demo\\table_output.txt', tableCode, 'utf-8');
console.log('success');
