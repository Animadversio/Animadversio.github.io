## Classic Music Collection

```python
b = corpus.parse('bwv66.6') # read from corpus collection

s = converter.parse('bach.mid') # direct read from midi
```





## Stream and Score





## Measure

Measure is (小节)

```python
excerpt = bachIn.measure(-1)
excerptChords = excerpt.chordify()
excerptChords.show('text')
```

Measure could be excerpt through `.measure` or `.measures()` function 



## Note

As we have seen in a score, a note has the following properties

* Offset 
  * Note the offset of a note is intrinsically defined relatively, relative to the start of the last object, so if a note is in a measure, then the notes' offset is relative to the start of the measure
  * `score.flat` can flat the element hierarchy in score object, thus each note will have its offset relative to the start of the whole piece instead of each measure. 
* Pitch
* Duration: length of the note, just like on the score. 
  * Normally measured in the unit of quarter length. (四分音符的个数)
  * https://en.wikipedia.org/wiki/Note_value



Note that chords are a different class of object from single note, which has a tuple attribute called pitches. 

## Play Music

To play music from object within music21, one way is to use `pygame` as player. 

Though the rendering engine for violin is pretty bad, it's a way to examine changes to your music. 

```python
btv = corpus.parse('beethoven/opus18no1/movement1.mxl')
sp = midi.realtime.StreamPlayer(btv)
sp.play()
```

