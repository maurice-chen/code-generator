{
  "apifoxProject": "1.0.0",
  "info": {
    "name": "优学堂",
    "description": "",
    "mockRule": {
      "rules": [],
      "enableSystemRule": true
    }
  },
  "responseCollection": [],
  "apiCollection": [
    {
      "name": "根目录",
      "parentId": 0,
      "serverId": "",
      "description": null,
      "preProcessors": [],
      "postProcessors": [],
      "auth": {},
      "items": [
        {
          "name": "${table.tableComment}",
          "parentId": 0,
          "serverId": "",
          "description": "",
          "preProcessors": [],
          "postProcessors": [],
          "auth": {},
          "items": [
            {
              "name": "查询分页",
              "api": {
                "method": "post",
                "path": "/${urlPrefix}/${table.controllerPath}/page",
                "parameters": {
                  "path": [],
                  "query": [],
                  "cookie": [],
                  "header": []
                },
                "auth": {},
                "commonParameters": {
                  "query": [],
                  "body": [],
                  "cookie": [],
                  "header": []
                },
                "responses": [
                  {
                    "name": "成功",
                    "code": 200,
                    "contentType": "json",
                    "jsonSchema": {
                      "type": "object",
                      "properties": {
                        "message": {
                          "type": "string",
                          "title": "执行后的信息"
                        },
                        "status": {
                          "type": "string",
                          "title": "请求状态码",
                          "description": "200 表示服务器执行成功"
                        },
                        "executeCode": {
                          "type": "string",
                          "title": "执行状态码",
                          "description": "200 表示执行成功，否则根据对应的代码去查看错误类型"
                        },
                        "timestamp": {
                          "type": "string",
                          "title": "当前服务器时间戳"
                        },
                        "data": {
                          "type": "object",
                          "properties": {
                            "first": {
                              "type": "string",
                              "title": "是否第一页"
                            },
                            "last": {
                              "type": "string",
                              "title": "是否最后一页"
                            },
                            "number": {
                              "type": "string",
                              "title": "第几页"
                            },
                            "numberOfElements": {
                              "type": "string",
                              "title": "当前页数量"
                            },
                            "size": {
                              "type": "string",
                              "title": "每页分页的大小"
                            },
                            "elements": {
                              "$ref": "#/definitions/${table.id}"
                            }
                          },
                          "required": [
                            "first",
                            "last",
                            "number",
                            "numberOfElements",
                            "size"
                          ],
                          "title": "数据内容"
                        }
                      },
                      "required": [
                        "message",
                        "status",
                        "executeCode",
                        "timestamp",
                        "data"
                      ]
                    }
                  }
                ],
                "responseExamples": [],
                "requestBody": {
                  "type": "application/x-www-form-urlencoded",
                  "parameters": [
                    {
                      "name": "number",
                      "required": true,
                      "description": "分页的页面，从 1 开始为第一页",
                      "sampleValue": "1",
                      "type": "text"
                    },
                    {
                      "name": "size",
                      "required": true,
                      "description": "分页的大小，默认为 10 条",
                      "sampleValue": "10",
                      "type": "text"
                    }
                  ]
                },
                "description": "查询分页接口\n\n权限条件：\n需要当前用户存在\"perms[${table.pluginName}:page]\"才能使用\n\n查询条件说明: \n1.接口支持动态条件查询，根据响应数据的 elements 节点的字段内容组合查询，具体查询格式为:filter_[字段名_条件]=值的形式进行组合查询。\n2.条件支持:between(范围查询，需要传数组值)，eq(等于查询)，eqn(等于 null 查询)，ne (不等于查询)，nen(不等于null查询)，gte(大于等于查询)，gt(大于查询)，in(包含查询，需要传数组值)，nin(不包含查询，需要传数组值)，llike(左模糊查询), rlike(右模糊查询，like(左右模糊查询)，lte(小于等于查询), lt(小于查询)",
                "tags": [],
                "status": "released",
                "serverId": "",
                "operationId": "",
                "sourceUrl": "",
                "ordering": 3,
                "cases": [],
                "mocks": []
              }
            },
            {
              "name": "获取所有信息",
              "api": {
                "method": "post",
                "path": "/${urlPrefix}/${table.controllerPath}/find",
                "parameters": {
                  "path": [],
                  "query": [],
                  "cookie": [],
                  "header": []
                },
                "auth": {},
                "commonParameters": {
                  "query": [],
                  "body": [],
                  "cookie": [],
                  "header": []
                },
                "responses": [
                  {
                    "name": "成功",
                    "code": 200,
                    "contentType": "json",
                    "jsonSchema": {
                      "type": "object",
                      "properties": {
                        "message": {
                          "type": "string",
                          "title": "执行后的信息"
                        },
                        "status": {
                          "type": "integer",
                          "title": "请求状态码",
                          "description": "200 表示服务器执行成功"
                        },
                        "executeCode": {
                          "type": "string",
                          "title": "执行状态码",
                          "description": "200 表示执行成功，否则根据对应的代码去查看错误类型"
                        },
                        "timestamp": {
                          "type": "integer",
                          "title": "当前服务器时间戳"
                        },
                        "data": {
                          "type": "array",
                          "items": {
                            "$ref": "#/definitions/${table.id}"
                          }
                        }
                      },
                      "required": [
                        "message",
                        "status",
                        "executeCode",
                        "data",
                        "timestamp"
                      ]
                    }
                  }
                ],
                "responseExamples": [],
                "requestBody": {
                  "type": "application/x-www-form-urlencoded",
                  "parameters": []
                },
                "description": "获取所有接口\n\n权限条件：\n需要当前用户存在\"perms[${table.pluginName}:find]\"才能使用\n\n查询条件说明:\n1.接口支持动态条件查询，根据响应数据的 data 节点的字段内容组合查询，具体查询格式为:filter_[字段名_条件]=值的形式进行组合查询。\n2.条件支持:between(范围查询，需要传数组值)，eq(等于查询)，eqn(等于 null 查询)，ne (不等于查询)，nen(不等于null查询)，gte(大于等于查询)，gt(大于查询)，in(包含查询，需要传数组值)，nin(不包含查询，需要传数组值)，llike(左模糊查询), rlike(右模糊查询，like(左右模糊查询)，lte(小于等于查询), lt(小于查询)",
                "tags": [],
                "status": "released",
                "serverId": "",
                "operationId": "",
                "sourceUrl": "",
                "ordering": 3,
                "cases": [],
                "mocks": []
              }
            },
            {
              "name": "获取信息",
              "api": {
                "method": "get",
                "path": "/${urlPrefix}/${table.controllerPath}/get",
                "parameters": {
                  "path": [],
                  "query": [
                    {
                      "name": "id",
                      "required": true,
                      "description": "主键id",
                      "type": "text"
                    }
                  ],
                  "cookie": [],
                  "header": []
                },
                "auth": {},
                "commonParameters": {
                  "query": [],
                  "body": [],
                  "cookie": [],
                  "header": []
                },
                "responses": [
                  {
                    "name": "成功",
                    "code": 200,
                    "contentType": "json",
                    "jsonSchema": {
                      "type": "object",
                      "properties": {
                        "message": {
                          "type": "string",
                          "title": "执行后的信息"
                        },
                        "status": {
                          "type": "integer",
                          "title": "请求状态码",
                          "description": "200 表示服务器执行成功"
                        },
                        "executeCode": {
                          "type": "string",
                          "title": "执行状态码",
                          "description": "200 表示执行成功，否则根据对应的代码去查看错误类型"
                        },
                        "timestamp": {
                          "type": "integer",
                          "title": "当前服务器时间戳"
                        },
                        "data": {
                          "$ref": "#/definitions/${table.id}"
                        }
                      },
                      "required": [
                        "message",
                        "status",
                        "executeCode",
                        "timestamp",
                        "data"
                      ]
                    }
                  }
                ],
                "responseExamples": [],
                "requestBody": {
                  "type": "none",
                  "parameters": []
                },
                "description": "编辑需要读取信息的接口：\n\n权限条件：需要当前用户存在\"prems[${table.pluginName}:get]\"才能使用",
                "tags": [],
                "status": "released",
                "serverId": "",
                "operationId": "",
                "sourceUrl": "",
                "ordering": 9,
                "cases": [],
                "mocks": []
              }
            },
            {
              "name": "保存信息",
              "api": {
                "method": "post",
                "path": "/${urlPrefix}/${table.controllerPath}/save",
                "parameters": {
                  "path": [],
                  "query": [],
                  "cookie": [],
                  "header": []
                },
                "auth": {},
                "commonParameters": {
                  "query": [],
                  "body": [],
                  "cookie": [],
                  "header": []
                },
                "responses": [
                  {
                    "name": "成功",
                    "code": 200,
                    "contentType": "json",
                    "jsonSchema": {
                      "type": "object",
                      "properties": {
                        "message": {
                          "type": "string",
                          "title": "执行后的信息"
                        },
                        "status": {
                          "type": "integer",
                          "title": "请求状态码",
                          "description": "200 表示服务器执行成功"
                        },
                        "executeCode": {
                          "type": "string",
                          "title": "执行状态码",
                          "description": "200 表示执行成功，否则根据对应的代码去查看错误类型"
                        },
                        "timestamp": {
                          "type": "string",
                          "title": "当前服务器时间戳"
                        },
                        "data": {
                          "type": "integer",
                          "title": "主键 id"
                        }
                      },
                      "required": [
                        "message",
                        "status",
                        "timestamp",
                        "executeCode",
                        "data"
                      ]
                    }
                  }
                ],
                "responseExamples": [],
                "requestBody": {
                  "type": "application/json",
                  "parameters": [
                  ],
                  "jsonSchema": {
                    "$ref": "#/definitions/${table.id}"
                  },
                  "sampleValue": ""
                },
                "description": "保存接口，用于添加或编辑页面输入完成时，提交保存的接口\n\n权限条件：需要当前用户存在\"prems[${table.pluginName}:save]\"才能使用",
                "tags": [],
                "status": "released",
                "serverId": "",
                "operationId": "",
                "sourceUrl": "",
                "ordering": 27,
                "cases": [],
                "mocks": []
              }
            },
            {
              "name": "删除信息",
              "api": {
                "method": "post",
                "path": "/${urlPrefix}/${table.controllerPath}/delete",
                "parameters": {
                  "path": [],
                  "query": [],
                  "cookie": [],
                  "header": []
                },
                "auth": {},
                "commonParameters": {
                  "query": [],
                  "body": [],
                  "cookie": [],
                  "header": []
                },
                "responses": [
                  {
                    "name": "成功",
                    "code": 200,
                    "contentType": "json",
                    "jsonSchema": {
                      "type": "object",
                      "properties": {
                        "message": {
                          "type": "string",
                          "title": "执行后的信息"
                        },
                        "status": {
                          "type": "integer",
                          "title": "请求状态码",
                          "description": "200 表示服务器执行成功"
                        },
                        "executeCode": {
                          "type": "string",
                          "title": "执行状态码",
                          "description": "200 表示执行成功，否则根据对应的代码去查看错误类型"
                        },
                        "timestamp": {
                          "type": "string",
                          "title": "当前服务器时间戳"
                        }
                      },
                      "required": [
                        "message",
                        "status",
                        "timestamp",
                        "executeCode"
                      ]
                    }
                  }
                ],
                "responseExamples": [],
                "requestBody": {
                  "type": "application/x-www-form-urlencoded",
                  "parameters": [
                    {
                      "name": "ids",
                      "required": true,
                      "description": "主键 id 集合",
                      "type": "integer"
                    }
                  ]
                },
                "description": "删除接口，ids 参数为主键 id 集合\n\n权限条件：需要当前用户存在\"prems[${table.pluginName}:delete]\"才能使用",
                "tags": [],
                "status": "released",
                "serverId": "",
                "operationId": "",
                "sourceUrl": "",
                "ordering": 33,
                "cases": [],
                "mocks": []
              }
            }
          ]
        }
      ]
    }
  ],
  "schemaCollection": [
    {
      "name": "根目录",
      "items": [
        {
          "name": "默认分类",
          "items": [
            {
              "name": "${table.tableComment}",
              "id": "#/definitions/${table.id}",
              "description": "",
              "schema": {
                "jsonSchema": {
                  "type": "object",
                  "properties": {
                    <#list table.columns as column>
                    "${column.javaVarName}": {
                      "type": "${column.jsonTypeName!'object'}",
                      "title": "${column.columnComment}"
                    }<#if column_index < table.columns?size - 1>,</#if>
                    </#list>
                  },
                  "required": [
                    <#list table.columns as column>
                    "${column.javaVarName}"<#if column_index < table.columns?size - 1>,</#if>
                    </#list>
                  ]
                }
              }
            }
          ]
        }
      ]
    }
  ],
  "commonScripts": [],
  "globalVariables": [],
  "commonParameters": null
}