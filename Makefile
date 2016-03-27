EXAMPLES = simple.native variable.native load.native gradient.native linear_regression.native variable2.native

%.native: .FORCE
	ocamlbuild examples/$@

gen.native: .FORCE
	ocamlbuild src/gen_ops/gen.native

src/graph/ops: gen.native
	LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./gen.native

run: $(EXAMPLES)
	$(foreach ex,$(EXAMPLES),LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./$(ex);)

lr_gnuplot: linear_regression_gnuplot.native
	LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./linear_regression_gnuplot.native

nn_gnuplot: nn_gnuplot.native
	LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./nn_gnuplot.native

mnist_nn: mnist/mnist_nn.native
	LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./mnist_nn.native

mnist_linear: mnist/mnist_linear.native
	LD_LIBRARY_PATH=./lib:$(LD_LIBRARY_PATH) ./mnist_linear.native

clean:
	rm -Rf _build/

.FORCE:
