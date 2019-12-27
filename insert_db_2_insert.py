#!/usr/bin/env python3
# -*- coding=utf-8 -*-
# 本脚由亁颐堂现任明教教主编写，用于乾颐盾Python课程！
# 教主QQ:605658506
# 亁颐堂官网www.qytang.com
# 教主技术进化论拓展你的技术新边疆
# https://ke.qq.com/course/271956?tuin=24199d8a

import boto3
from insert_db_0_db import stu_db
dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('staff')

with table.batch_writer() as batch:
    for student in stu_db:
        batch.put_item(Item=student)