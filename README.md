# Convert python docstrings to markdown

Converts a python file with docstrings into the markdown directory.

Run `make` without parameters to see latest help:
```
$ make
markdown             Convert xxx.py to markdown/ with: make markdown app="path/to/xxx.py"
clean                clean files
```

## Credits:

 Matteo Ferla: [Stackoverflow](https://stackoverflow.com/a/59128670) or [blogpost](https://blog.matteoferla.com/2019/11/convert-python-docstrings-to-github.html)


## Build:

```
$ make markdown app=~/prgs/CadQuery/projects/taperable-helix/taperable_helix/helix.py 
rm -rf *.py docs/ markdown/
(name=$(basename /home/wink/prgs/CadQuery/projects/taperable-helix/taperable_helix/helix.py .py) ;\
echo name=${name} ;\
cp /home/wink/prgs/CadQuery/projects/taperable-helix/taperable_helix/helix.py . ;\
mkdir docs ;\
sphinx-apidoc -o docs . sphinx-apidoc --full -A "Wink Saville" ;\
cat docs/conf.py moreconf > docs/new.conf.py ;\
mv docs/new.conf.py docs/conf.py ;\
make -C docs markdown ;\
mv docs/_build/markdown .)
name=helix
Creating file docs/helix.rst.
Creating file /home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs/conf.py.
Creating file /home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs/index.rst.
Creating file /home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs/Makefile.
Creating file /home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs/make.bat.
make[1]: Entering directory '/home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs'
Running Sphinx v3.2.1
loading translations [en]... done
making output directory... done
building [mo]: targets for 0 po files that are out of date
building [markdown]: targets for 2 source files that are out of date
updating environment: [new config] 2 added, 0 changed, 0 removed
reading sources... [100%] index                                                                                        
looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
writing output... [100%] index                                                                                         
/home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs/index.rst:: WARNING: The caption element not yet supported in Markdown.
build succeeded, 1 warning.

The markdown files are in _build/markdown.
make[1]: Leaving directory '/home/wink/prgs/python/projects/sphinx-docstrings-to-readme.md/docs'
(cq-dev) wink@3900x:~/prgs/python/projects/sphinx-docstrings-to-readme.md (master)
$ tree markdown/
markdown/
├── helix.md
└── index.md

0 directories, 2 files
```

## Result markdown/helix.md:

# helix module


### helix.helix(radius, pitch, height, taper_out_rpos=0, taper_in_rpos=0, inset_offset=0, horz_offset=0, vert_offset=0, first_t=0, last_t=1)
Returns a function, f. The funciton f takes one parameter,
an inclusive value between first_t and last_t.  We can then define
t_range=last_t-first_t and the rel_height=(last_t-t)/t_range. furthermore
when using the first_t=0 and last_t=1, the defaults, t is rel_height.
The value returned from f is a tuple(x, y, z) which defines a point
on the helix defined by the other parameters.

The helix() function has radius, pitch and height parameters to define a
basic helix. Using just those parameters you can create simple single
line helixes. But the primary purpose for helix() is to create a set
of helical “wires” using non-zero values for taper_rpos, horz_offset and
vert_offset to define solid helixes that can taper at each end to a point.
This is useful for creating internal and external threads for nuts and
bolts.  This is accomplished by invoking helix() multiple times with
same radius, pitch, taper_rpos, inset_offset, first_t, and last_t.
But with differing values for  horz_offset and vert_offset. And then
using the returned functions to define the helical edges of the thread.

Credit: Adam Urbanczyk from cadquery [forum post]([https://groups.google.com/g/cadquery/c/5kVRpECcxAU/m/7no7_ja6AAAJ](https://groups.google.com/g/cadquery/c/5kVRpECcxAU/m/7no7_ja6AAAJ))


* **Parameters**

    
    * **radius** (`float`) – of the basic helix.


    * **pitch** (`float`) – of pitch of the helix per revolution. I.e the distance
    between the height of a single “turn” of the helix.


    * **height** (`float`) – of the cyclinder containing the helix.


    * **taper_out_rpos** (`float`) – is a decimal fraction such that (taper_out_rpos
    \* t_range) defines the t value where tapering out from first_t ends.
    A ValueError exception is raised if taper_out_rpos < 0 or > 1 or
    taper_out_rpos > taper_in_rpos.


    * **taper_in_rpos** (`float`) – is a decimal fraction such that (taper_in_rpos
    \* t_range) defines the t value where tapering in begins. The tapering
    out ends at t = last_t.
    A ValueError exception is raised if taper_out_rpos < 0 or > 1 or
    taper_out_rpos > taper_in_rpos.


    * **inset_offset** (`float`) – the helix will start at z = inset_offset and will end
    at z = height - (2 \* inset_offset).


    * **horz_offset** (`float`) – is added to the nomimal radius of the helix.


    * **vert_offset** (`float`) – is added to the nonimal z location of the helix


    * **first_t** (`float`) – is the first t value passed to the returned function


    * **last_t** (`float`) – is the last t value passed to the returned function



* **Return type**

    `Callable`[[`float`], `Tuple`[`float`, `float`, `float`]]

