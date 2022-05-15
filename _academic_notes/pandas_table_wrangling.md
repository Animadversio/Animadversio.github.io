



## Multi-Indexing 

Just like in excel, you can have multi indexing columns for a table. 



### Level and Columns

`reset_index` transform existing indices to columns

`set_index`  transform columns to indices 

* `set_index(..., append=True)` will add a new level index. 
* If `False` it will discard all levels except the new one. 

> This name is really intuitive, `set_index` vs `reset_index`

### Order levels

You can use `swaplevel` to change order of levels. 



### Name the levels





### Groupby and aggregates 

`groupby` 

* You can group by columns or levels but you can only use one, not both
  * `groupby(by=[...])`
  * `groupby(level=(0,1,2))`

