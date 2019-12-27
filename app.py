from flask import Flask, render_template
import os
from insert_db_3_get_item import get_all_item
# 默认目录为当前目录的templates
template_dir = os.path.abspath('/AWS/templates')

app = Flask(__name__, template_folder=template_dir)

app.debug = True

@app.route('/')
def index():
    return render_template('index.html', devnet_main='乾颐堂AWS测试', active='首页')

@app.route('/staff_info')
def staff_info():
    staff_list = get_all_item('staff')
    return render_template('staff.html', staff_list=staff_list, active='员工信息')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)