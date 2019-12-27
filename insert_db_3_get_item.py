#!/usr/bin/env python3
# -*- coding=utf-8 -*-
# 本脚由亁颐堂现任明教教主编写，用于乾颐盾Python课程！
# 教主QQ:605658506
# 亁颐堂官网www.qytang.com
# 教主技术进化论拓展你的技术新边疆
# https://ke.qq.com/course/271956?tuin=24199d8a

import boto3
dynamodb = boto3.resource('dynamodb')

def get_all_item(table_name):
    table = dynamodb.Table(table_name)

    response = table.scan()
    data = response['Items']
    return data


if __name__ == '__main__':
    print(get_all_item('staff'))