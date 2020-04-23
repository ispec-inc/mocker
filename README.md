# mocmock
## Create Project

```
$ mocmock new my-project
```

## Add Endpoints
1. Edit config/routes.yml
```
routes:
+  users:
+    - get
+    - post
```
2. Run load command
```
$ mocmock load
```
Now created new json files for `/users`

3. Edit these json files
```
$ tree jsons
jsons
└── users
    ├── get.json
    └── patch.json
```

## Run MockServer
```
$ ruby main.rb
```
