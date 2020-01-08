## Motivation

`pandas` is a great tool for representing structured data in python, similar to `Table` in `matlab` and `dataframe` in `R` . 

Using it to interact with table data (like experimental records) on hard drive and process it in python is also great! 

## Create Dataframe

Source: 

* List of tuples
* np.ndarray
* dictionary 

## Data Structure

* `pandas` `array` 
  * Can be transformed into `numpy` by `.to_numpy()` . Or to normal `list` by `.to_list()` 

## Interaction

* Slicing using boolean array. and `df.index` is the normal row number starting from 0. 
  * `ExpTable[ExpTable.index == 100]`
  * Selecting rows using condition
    * `color_and_shape = df.loc[(df.Color == 'Green') & (df.Shape == 'Rectangle')]` 
  * `ExpTable.index[ExpTable.comments.str.contains("Evolution")]`
  * **Caveat**: you cannot use `np` type array to directly slice a `dataFrame`. But you can use it to slice the individual columns. 
* Filtering using sub-string pattern
  * `ExpTable.Expi[ExpTable.comments.str.contains("Evolution")]`