

## Stream and Score





## Measure

```python
excerpt = bachIn.measure(-1)
excerptChords = excerpt.chordify()
excerptChords.show('text')
```

Measure could be excerpt through `.measure` or `.measures()` function 



## Note

As we have seen in a score, a note has the following properties

* Offset 
* Pitch
* Duration: length of the note, just like on the score. 
  * https://en.wikipedia.org/wiki/Note_value
  * Normally measured in the unit of quarter length 



Note that chords are a different class of object from single note, which has a tuple attribute called pitches. 