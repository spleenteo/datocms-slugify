# datocms-slugify

## Scenario

In [DatoCMS](https://datocms.com), when you define a model, you can set [a truely useful field named _slug_](https://www.datocms.com/docs/introduction/slug-permalinks/) that can be linked to an existing different field as _source_. For instance: a _Post_ model, might have a _title_ field and a _slug_ genrated from the title once you save the entry for the very first time.

You might have a problem __if you add the slug field to an existing model__. Since it has been created before, the _magic-by-dato_ won't works.

You need a script to create the missing slugs.

If a _slug_ entry already exists, the script won't touch it and will go further.

# Install

* Clone the repo `git clone git@github.com:spleenteo/datocms-slugify.git`
* `cd datocms-slugify`
* Create a `.env`
* Add the ReadWrite Token from your DatoCMS
* `DATO_API_TOKEN_RW=blablablablablabla`
* Edit the `config.yml` file and:
    - Add a block for each model you wish to update
    - Add the name of the model, just to better understand what is going on
    - Add the ID of the model that must be updated
    - Add the name of the field you wish to use to get the data for the new slug 
* Save the config file
* Run the script with `ruby ./datocms-slugify.rb`

# Do it at your own risk!

I've used this script several time finding no problems. Before executing it, make a backup and be sure of what you are doing.
In any case, in DatoCMS you can recover a previous version of each item.
`
