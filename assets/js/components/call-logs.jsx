import React, { Component } from "react";
import { Button, Icon, Input, Modal, Table } from "antd";
import mtz from "moment-timezone";

const { TextArea } = Input;

export default class CallLogs extends Component {
  state = {
    call_logs: [],
    open: false,
    adding: false,
    logNote: ""
  };

  componentWillReceiveProps(nextProps) {
    this.setState({ adding: false });
  }

  openMe = () => {
    this.props.channel.push(`call-logs-for-${this.props.id}`);
    this.setState({ open: true });
  };

  addCallLog = () =>
    this.props.channel.push(`add-call-log-${this.props.id}`, {
      note: this.state.logNote
    });

  wrapAddCallLog = wrapped => () =>
    this.props.channel.push(`add-call-log-${this.props.id}`, {
      note: this.state.logNote,
      result: wrapped
    });

  setLogNote = e => this.setState({ logNote: e.target.value });

  render() {
    if (!this.state.open) {
      return (
        <Button type="primary" onClick={this.openMe}>
          Call Logs
        </Button>
      );
    } else if (this.state.adding) {
      return (
        <Modal
          visible={this.state.adding}
          title="Add Call Notes"
          footer={[
            <Button onClick={() => this.setState({ adding: false })}>
              Cancel
            </Button>,
            <Button type="primary" onClick={this.addCallLog}>
              {" "}
              Record Call{" "}
            </Button>
          ].concat(
            this.props.category
              ? [
                  <Button
                    type="danger"
                    onClick={this.wrapAddCallLog("not-interested")}
                  >
                    Record Call and Mark as Not Interested
                  </Button>,
                  <Button onClick={this.wrapAddCallLog("call-back-later")}>
                    Record Call and Mark as Call Back Later
                  </Button>,
                  <Button onClick={this.wrapAddCallLog("success")}>
                    Record Call and Mark as Success
                  </Button>
                ]
              : []
          )}
        >
          <TextArea
            rows={5}
            onChange={this.setLogNote}
            value={this.state.logNote}
            pageSize={5}
            pagination={{
              pageSize: 5,
              total: Math.ceil(this.props.calls.length / 5),
              defaultCurrent: 1
            }}
          />
        </Modal>
      );
    } else {
      return (
        <Modal
          visible={true}
          title="Call Notes"
          okText="Add Call"
          width="60%"
          onCancel={() => this.setState({ open: false })}
          onOk={() => this.setState({ adding: true })}
        >
          {this.props.calls === undefined ? (
            <Icon type="loading" />
          ) : (
            <Table
              size="small"
              columns={[
                {
                  title: "Caller",
                  dataIndex: "actor",
                  key: "actor",
                  width: 200
                },
                {
                  title: "Called At",
                  dataIndex: "timestamp",
                  key: "timestamp",
                  width: 125
                }
              ].concat(
                this.props.category
                  ? [
                      {
                        title: "Result",
                        dataIndex: "result",
                        key: "result",
                        width: 125
                      },

                      { title: "Notes", dataIndex: "note", key: "note" }
                    ]
                  : [{ title: "Notes", dataIndex: "note", key: "note" }]
              )}
              dataSource={this.props.calls.map(c =>
                Object.assign(c, {
                  timestamp: new Date(c.timestamp).toString()
                })
              )}
            />
          )}
        </Modal>
      );
    }
  }
}

<Icon type="loading" />;
