#myudf.py
def enumerate_bag(input):
    output = []
    for rank, item in enumerate(input):
        output.append(tuple([rank+1] + list(item)))
    return output
