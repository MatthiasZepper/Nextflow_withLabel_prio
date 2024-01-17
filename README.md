# Multiple Process Label Configuration Priority

This small toy project was created to experimentally establish the configuration priority for a process with multiple labels in Nextflow.

## Motivation

While the Nextflow manual explains the [selector priority](https://nextflow.io/docs/latest/config.html#selector-priority) for selectors of different kinds (e.g. `withLabel` versus `withName`), no documentation exists on the resolution of multiple selectors of the same kind.

The desire to establish a definitive answer to the handling of multiple `withLabel` selectors was guided by the prospect of optimizing resource use by Nextflow pipelines through atomic process labels.

Within [nf-core](https://nf-co.re/modules), a large collection of Nextflow pipelines and modules, the resources of a process are currently set based on a handful of labels like `process_low`, `process_medium`, `process_high`. Each of these specifies a fixed combination of CPU, memory and runtime. The rationale for this approach is, that those settings go hand in hand on some HPC and Cloud platforms, e.g all nodes having 12 CPUs and 6 GB RAM per CPU.

However, it also leads to huge inefficiencies, for example a single-threaded tool blocking 12 cores just because it needs a particularly long runtime. Therefore, I proposed an [alternative approach](https://nfcore.slack.com/archives/CJRH30T6V/p1680090424544209), that was modelled after the [Tailwind philosophy](https://tailwindcss.com/) and would **add** additional labels with more granularity to the modules, e.g. `cpu_single`, `memory_medium` or  `runtime_long` etc.

These would supplement the existing labels, but introduce the option to fine-tune a pipeline if desired. In particular for use cases, where one pipeline is needed for a large number of samples, such tweaks could reduce computing costs significantly.

## The experimental setup

The whole experimental pipeline consists of one process having various labels: `group_top` and `group_bottom` for the grouped configs and granular labels for fine-tuning: `cpu_setting`, `memory_setting` and `runtime_setting`.

For easier interpretation of the output, the `top` group contains even settings _(2,4,6)_ and the `bottom` group specifies odd values _(1,3,5)_. The granular labels use the value _10_ for each.

It is designed to be run using the `-c` flag to specify different config files and observe the effects of various configurations.

```bash
    nextflow run -c groups_top_bottom.config .
```

## Results

In Nextflow, when a process has multiple labels, the config priority is determined by the order in which the `withLabel` declarations are specified inside the configuration file. The configuration of the label specified last will take precedence over the previous ones.

## Contributions

Thanks to [Joon Klaps](https://github.com/Joon-Klaps) and [Arthur Gymer](https://github.com/awgymer) for helpful suggestions and discussion of the subject.
