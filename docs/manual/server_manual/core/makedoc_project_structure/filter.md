# Filter {#md_filter .concept}

Filter file describes specific content/objects of TIBCO project to be documented, designed as JSON string - set of true/false values. Server installation comes with set of useful predefined filters. Following code shows filter fragment.

```

{
	"filter": [
		{
			"Projects": true,
			"children": [
				{
					"process": true,
					"children": [
						{
							"modificationTime": false
						},
						{
							"diagram": "true"
						},
						{
							"children": [
								{
									"starterActivity": "true"
								},
								{
									"endActivity": "true"
								},
								{
									"others": "true"
								},
								{
									"mapper": "true"
								},
								{
									"inputbindings": "true"
								}
							],
...
		
```

**Parent topic:**[MakeDoc project structure](../../core/makedoc_project_structure/md_project_structure.md)

